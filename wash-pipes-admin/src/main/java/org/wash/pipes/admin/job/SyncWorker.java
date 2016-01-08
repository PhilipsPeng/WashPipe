package org.wash.pipes.admin.job;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;
import org.wash.pipes.core.model.ContactInfo;
import org.wash.pipes.core.model.ContactInfo.SEND_MAIL_PROCESS;
import org.wash.pipes.core.model.ContactInfo.SEND_MAIL_STATUS;
import org.wash.pipes.core.model.Member;
import org.wash.pipes.core.model.ProjectGroup;
import org.wash.pipes.core.service.ContactInfoService;
import org.wash.pipes.core.service.EmailNotificationService;
import org.wash.pipes.core.service.ProjectGroupService;

/**
 * A synchronous worker
 */
@Component("syncWorker")
public class SyncWorker implements Worker {
	
	@Autowired 
	ContactInfoService contactInfoService;
	@Autowired
	private ProjectGroupService projectGroupService;
	@Autowired
	EmailNotificationService emailNotificationService;

//	protected static Logger logger = Logger.getLogger("service");
	
	@Transactional
	public void work() {
//		String threadName = Thread.currentThread().getName();
//		System.out.println("   " + threadName + " has began working.");
////		logger.debug("   " + threadName + " has began working.");
//        try {
////        	logger.debug("working...");
//        	System.out.println("working...");
//            Thread.sleep(10000); // simulates work
//        }
//        catch (InterruptedException e) {
//            Thread.currentThread().interrupt();
//        }
////        logger.debug("   " + threadName + " has completed work.");
//        System.out.println("   " + threadName + " has completed work.");
        System.out.println("==============send mail job start===============");
        List<ContactInfo> contactInfoList = 
				contactInfoService.getContactInfoForNeMailStatus(
						SEND_MAIL_STATUS.FINISH);
		
//		Calendar now = Calendar.getInstance();
        Date now = new Date();
        Date sendMailTime = null;
//		Calendar sendMailTime = Calendar.getInstance();
		for(ContactInfo contactInfo:contactInfoList) {
			Member member = contactInfo.getMember();
			ProjectGroup projectGroup = contactInfo.getProjectGroup();
			projectGroupService.updateProjectGroup(projectGroup);
			int mailNum = projectGroup.getMailNum();
			int mailJobDay = projectGroup.getMailJobDay();
			System.out.println(contactInfo.getSendMailTime());
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
			try {
				System.out.println("___)))))))))))"+sdf.parse(contactInfo.getSendMailTime()));
				sendMailTime = sdf.parse(contactInfo.getSendMailTime());
			} catch (ParseException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			long diff = 
				now.getTime()-sendMailTime.getTime();
			System.out.println(now.getTime());
			System.out.println(sendMailTime.getTime());
			System.out.println("======="+diff);
			System.out.println("---------wwwww--))))"+diff/(1000*60));
//			if(diff/(1000*60*60*24) < mailJobDay) 
//			if(diff/(1000*60*60) < 1) //一小時
			if(diff/(1000*60) < 2)  //2分鐘  ,for every mail 2 min send once mail 
			{
				continue;
			}
			System.out.println(contactInfo.getName());
			System.out.println(contactInfo.getEmail());
			if(contactInfo.getSendMailStatus().equals(SEND_MAIL_STATUS.SUCCESS)) {
				switch (contactInfo.getSendMailProcess()) {
				case FIRST:
					contactInfo.setSendMailProcess(SEND_MAIL_PROCESS.SECOND);
					break;
				case SECOND:
					contactInfo.setSendMailProcess(SEND_MAIL_PROCESS.THIRD);
					break;
				case THIRD:
					contactInfo.setSendMailProcess(SEND_MAIL_PROCESS.FOURTH);
					break;
				case FOURTH:
					contactInfo.setSendMailProcess(SEND_MAIL_PROCESS.FIFTH);
					break;
				default:
					break;
				}
			}
//			List<MailConfig> mailConfigList = projectGroup.getMailConfigList();
//			if(!mailConfigList.isEmpty()) {
			boolean isFinalMail = contactInfo.getSendMailProcess().getMailNum().equals(mailNum);
			System.out.println(mailNum);
			System.out.println(contactInfo.getSendMailProcess().getMailNum());
			System.out.println("==isFinalMail=="+isFinalMail);	
			boolean isSendStatus = 
						emailNotificationService.sendContactNotification(
								contactInfo, projectGroup, member, isFinalMail);
				if(isSendStatus) {
					if(contactInfo.getSendMailProcess().getMailNum().equals(mailNum)) {
						contactInfo.setSendMailProcess(SEND_MAIL_PROCESS.END);
						contactInfo.setSendMailStatus(SEND_MAIL_STATUS.FINISH);
					}else {
						contactInfo.setSendMailStatus(SEND_MAIL_STATUS.SUCCESS);
					}
//					now = Calendar.getInstance();
					now = new Date();
					contactInfo.setSendMailTime(sdf.format(now.getTime()));
				}else {
					contactInfo.setSendMailStatus(SEND_MAIL_STATUS.FAIL);
				}
//			}else {
//				contactInfo.setSendMailStatus(SEND_MAIL_STATUS.MAIL_CONFIG_EMPTY);
//			}
			
			contactInfoService.updateContactInfo(contactInfo);
			
			try {
				Thread.sleep(60000);//每幫發信間隔時間，目前一分鐘
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		System.out.println("==============send mail job end===============");
	}
	
}

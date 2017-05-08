package egovframework.com.ems.service;

import java.io.Serializable;
import java.util.List;

import org.apache.commons.lang.builder.ToStringBuilder;

@SuppressWarnings("serial")
public class MailMessageVO implements Serializable {
	
	private String sendSe = "";
	
    private String senderEmail = "";
    
    private String senderName = "";
    
    private String subject = "";

    private String content = "";
    
    private List<String> emails = null;
    
    private String receptorEmail = "";
        
    public String getSendSe() {
        return sendSe;
    }

    public void setSendSe(String sendSe) {
        this.sendSe = sendSe;
    }
    
	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getSenderEmail() {
        return senderEmail;
    }

    public void setSenderEmail(String senderEmail) {
        this.senderEmail = senderEmail;
    }
    
    public String getSenderName() {
        return senderName;
    }

    public void setSenderName(String senderName) {
        this.senderName = senderName;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }
    
    public List<String> getEmails() {
        return emails;
    }

    public void setEmails(List<String> emails) {
        this.emails = emails;
    }
    
    public String getReceptorEmail() {
        return receptorEmail;
    }

    public void setReceptorEmail(String receptorEmail) {
        this.receptorEmail = receptorEmail;
    }

    public String toString() {
        return ToStringBuilder.reflectionToString(this);
    }

}

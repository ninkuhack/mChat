package dev.eggSaint.mChat.model;

import java.io.Serializable;
import java.util.Date;

public class Message implements Serializable {
  private static final long serialVersionUID = 1L;
  private String content;
  private String contentOwn;
  private String contentDes;
  private Date time;

  public Message() {
    this.content = "";
    this.contentOwn = "";
    this.contentDes = "";
    this.time = new Date();
  }

  public String getContent() {
    return content;
  }

  public void setContent(String content) {
    this.content = content;
  }

  public String getContentOwn() {
    return contentOwn;
  }

  public void setContentOwn(String contentOwn) {
    this.contentOwn = contentOwn;
  }

  public String getContentDes() {
    return contentDes;
  }

  public void setContentDes(String contentDes) {
    this.contentDes = contentDes;
  }

  public Date getTime() {
    return time;
  }

  public void setTime(Date time) {
    this.time = time;
  }

  @Override
  public String toString() {
    final StringBuffer sb = new StringBuffer("Message{");
    sb.append("content='").append(content).append('\'');
    sb.append(", contentOwn='").append(contentOwn).append('\'');
    sb.append(", contentDes='").append(contentDes).append('\'');
    sb.append(", time=").append(time);
    sb.append('}');
    return sb.toString();
  }
}

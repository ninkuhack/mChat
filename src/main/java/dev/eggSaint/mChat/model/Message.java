package dev.eggSaint.mChat.model;

import java.io.Serializable;
import java.util.Date;

public class Message implements Serializable {
  private static final long serialVersionUID = 1L;
  private String content;
  private String sender;
  private String receiver;
  private Date time;

  public Message() {
    this.content = "";
    this.sender = "";
    this.receiver = "";
    this.time = new Date();
  }

  public String getContent() {
    return content;
  }

  public void setContent(String content) {
    this.content = content;
  }

  public String getSender() {
    return sender;
  }

  public void setSender(String sender) {
    this.sender = sender;
  }

  public String getReceiver() {
    return receiver;
  }

  public void setReceiver(String receiver) {
    this.receiver = receiver;
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
    sb.append(", sender='").append(sender).append('\'');
    sb.append(", receiver='").append(receiver).append('\'');
    sb.append(", time=").append(time);
    sb.append('}');
    return sb.toString();
  }
}

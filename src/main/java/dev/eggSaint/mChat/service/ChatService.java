package dev.eggSaint.mChat.service;

import dev.eggSaint.mChat.model.Message;
import dev.eggSaint.mChat.model.UserChat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Service;

import java.util.LinkedHashSet;
import java.util.Set;

/**
 * Created by ntminh on 7/11/2016.
 */
@Service
public class ChatService {
    @Autowired
    private SimpMessagingTemplate template;
    private Set<UserChat> listUserChat = new LinkedHashSet<>();

    public void addNewUserChat(UserChat userChat){
        listUserChat.add(userChat);
        sendListUserToClients();
    }

    public void removeUserChat(UserChat userChat){
        listUserChat.remove(userChat);
        sendListUserToClients();
    }

    public void sendListUserToClients() {
        template.convertAndSend("/userChat/user", listUserChat);
    }

    public void sendMessageToClients(Message message){
        System.out.println("message = " + message);
        if("All".equals(message.getReceiver())){
            template.convertAndSend("/userChat/messageAll", message);
        } else {
            template.convertAndSend("/userChat/message-" + message.getReceiver(), message);
        }
    }

}

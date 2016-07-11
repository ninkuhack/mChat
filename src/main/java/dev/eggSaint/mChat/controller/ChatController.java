package dev.eggSaint.mChat.controller;

import dev.eggSaint.mChat.model.Message;
import dev.eggSaint.mChat.model.UserChat;
import dev.eggSaint.mChat.service.ChatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.stereotype.Controller;

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

/**
 * Created by ninkuhack on 11/07/2016.
 */
@Controller
public class ChatController {

    @Autowired
    ChatService chatService;
    private Set<UserChat> listUserChat = new LinkedHashSet<>();
    private List<Message> messages = new ArrayList<>();

    @MessageMapping("/addMessage")
    public void addMessage(Message message) throws Exception {
        messages.add(message);
        chatService.updatePriceAndBroadcast();
    }

    @MessageMapping("/newConnect")
    public void newConnect() {
        chatService.updatePriceAndBroadcast();
    }

}

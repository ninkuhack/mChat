package dev.eggSaint.mChat.controller;

import dev.eggSaint.mChat.model.Stock;
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
//    private TaskScheduler scheduler = new ConcurrentTaskScheduler();
    private Set<UserChat> listUserChat = new LinkedHashSet<>();
    private List<Stock> messages = new ArrayList<>();

    /**
     * Invoked after bean creation is complete, this method will schedule
     * updatePriceAndBroacast every 1 second
     */
//  @PostConstruct
//  private void broadcastTimePeriodically() {
//    scheduler.scheduleAtFixedRate(new Runnable() {
//      @Override public void run() {
//        updatePriceAndBroadcast();
//      }
//    }, 10000);
//  }

    /**
     * Handler to add one stock
     */
    @MessageMapping("/addStock")
    public void addStock(Stock stock) throws Exception {
        messages.add(stock);
        chatService.updatePriceAndBroadcast();
    }

    /**
     * Handler to remove all stocks
     */
    @MessageMapping("/removeAllStocks")
    public void removeAllStocks() {
        messages.clear();
        chatService.updatePriceAndBroadcast();
    }

    @MessageMapping("/newConnect")
    public void newConnect() {
        chatService.updatePriceAndBroadcast();
    }

}

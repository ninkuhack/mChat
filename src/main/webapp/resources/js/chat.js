$(function() {
    new ChatApp();
});

var ChatApp = function(){
    this.receiverOfChat = "All";
    this.socket = new SockJS("/stomp");
    this.stompClient = Stomp.over(this.socket);
    this.connectServer();
    $('#destination').html(this.receiverOfChat);
    var $chatApp = this;
    $('#newMessageInput').keypress(function( event) {
        if ( event.which == 13 ) {
            event.preventDefault();
            $chatApp.sendMessage();
            $('#newMessageInput').val("");
        }
    });
    $('#listUser').on('click', 'a.participant', function() {
        $chatApp.receiverOfChat = $(this).attr('data').trim();
        $('#destination').html($chatApp.receiverOfChat);
        $('#chatContent').find(".content").addClass("hidden");
        $('#chatContent').find("."+$chatApp.receiverOfChat).removeClass("hidden");
        $('#listUser').find("#"+$chatApp.receiverOfChat).addClass("hidden");
    });
}
ChatApp.prototype = {
    connectServer: function(){
        this.stompClient.connect("guest", "guest", this.connectCallback.bind(this), this.errorCallback);
    },
    connectCallback: function() {
        var myUsername = $('#myUsername').html();
        this.stompClient.subscribe('/userChat/user', this.renderParticipant);
        this.stompClient.send('/chat/newConnect');
        this.stompClient.subscribe('/userChat/messageAll', this.renderMessageForAll.bind(this));
        this.stompClient.subscribe('/userChat/message-' + myUsername, this.renderMessageForMe.bind(this));
    },
    renderParticipant: function(data){
        var listUser = JSON.parse(data.body);
        $('#numberOfUser').html(listUser.length);
        var listUserFrame = $('#listUser');
        listUserFrame.empty();
        var listUserHtml="<li> <span class='input-icon fui-user'></span> <a class='participant' " +
            "href='javascript:;' data='All'> All </a> </li>";
        for(var i=0; i<listUser.length; i++){
            var nameOfUser = listUser[i].name;
            listUserHtml+="<li> <span class='input-icon fui-user'></span>" +
                "<span id='" + nameOfUser + "' class='input-icon fui-chat pull-right hidden'></span> <a class='participant' " +
                "href='javascript:;' data='" + nameOfUser + "'> "+ nameOfUser +" </a> </li>";
        }
        listUserFrame.append(listUserHtml);
    },
    errorCallback: function(error) {
        alert(error.headers.message);
    },
    sendMessage: function(){
        var myUsername = $('#myUsername').html();
        var content = $('#newMessageInput').val();
        var receiver = $('#destination').html();
        if(content==""){
            return;
        }
        if(receiver!="All"){
            $('#chatContent').append("<div class='content " + receiver + "'><small><strong style='color:#f5901e;'>Me : </strong>"
                + content + "</small></div>");
        }
        var jsonData = JSON.stringify({ 'content': content, 'sender': myUsername, 'receiver': receiver});
        this.stompClient.send("/chat/sendMessage", {}, jsonData);
    },
    renderMessageForAll: function(data){
        var message = JSON.parse(data.body);
        var myUsername = $('#myUsername').html();
        var chatContent = $('#chatContent');
        var isHidden = ('All' === this.receiverOfChat ? "" : " hidden");
        var content = "<div class='content All"+ isHidden +"'><small><strong" + (message.sender==myUsername?" style='color:#f5901e;'":"") + ">"+ message.sender +": </strong>"
            + message.content + "</small></div>";
        chatContent.append(content);
    },
    renderMessageForMe: function(data){
        var message = JSON.parse(data.body);
        var chatContent = $('#chatContent');
        var isHidden = (message.sender === this.receiverOfChat ? "" : " hidden");
        var content = "<div class='content " + message.sender + isHidden + "'><small><strong>"+ message.sender +": </strong>"
            + message.content + "</small></div>";
        chatContent.append(content);
        if(isHidden!=""){
            $('#listUser').find("#"+message.sender).removeClass("hidden");
        }
    }
}
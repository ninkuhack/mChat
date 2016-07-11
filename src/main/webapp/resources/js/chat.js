$(function() {
    chatApp = new ChatApp();
});

var ChatApp = function(){
    this.socket = new SockJS("/stomp");
    this.stompClient = Stomp.over(this.socket);
    this.connectServer();
    $( window ).unload(function() {
        this.stompClient.send('/logout');
    });
}
ChatApp.prototype = {
    connectServer: function(){
        this.stompClient.connect("guest", "guest", this.connectCallback.bind(this), this.errorCallback);
    },
    connectCallback: function() {
        this.stompClient.subscribe('/userChat/user', this.renderParticipant);
        this.stompClient.send('/chat/newConnect');
    },
    renderParticipant: function(data){
        var listUser = JSON.parse(data.body);
        $('#numberOfUser').html(listUser.length);
        var listUserFrame = $('#listUser');
        listUserFrame.empty();
        var listUserHtml="";
        for(var i=0; i<listUser.length; i++){
            listUserHtml+="<li> <span class='input-icon fui-user'></span> <a href='#'> "+ listUser[i].name +" </a> </li>";
        }
        listUserFrame.append(listUserHtml);
    },
    errorCallback: function(error) {
        alert(error.headers.message);
    }
}
//function renderPrice(frame) {
//    var prices = JSON.parse(frame.body);
//    $('#price').empty();
//    for(var i in prices) {
//        var price = prices[i];
//        $('#price').append(
//            $('<tr>').append(
//                $('<td>').html(price.code),
//                $('<td>').html(price.price.toFixed(2)),
//                $('<td>').html(price.timeStr)
//            )
//        );
//    }
//}

//var connectCallback = function() {
//    stompClient.subscribe('/user/user', renderPrice);
//    stompClient.send('/chat/newConnect');
//};
//
//var errorCallback = function(error) {
//    alert(error.headers.message);
//};
//
//stompClient.connect("guest", "guest", connectCallback, errorCallback);
//
//
//// Register handler for add button
//$(document).ready(function() {
//    $('.add').click(function(e){
//        e.preventDefault();
//        var code = $('.new .code').val();
//        var price = Number($('.new .price').val());
//        var jsonstr = JSON.stringify({ 'code': code, 'price': price });
//        stompClient.send("/chat/addStock", {}, jsonstr);
//        return false;
//    });
//});
//
//// Register handler for remove all button
//$(document).ready(function() {
//    $('.remove-all').click(function(e) {
//        e.preventDefault();
//        stompClient.send("/chat/removeAllStocks");
//        return false;
//    });
//});
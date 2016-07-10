<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>mChat</title>
    <link href="${contextPath}/resources/css/bootstrap.min.css" rel="stylesheet"/>
    <%--<link href="${contextPath}/resources/css/sticky-footer-navbar.css" rel="stylesheet"/>--%>
    <link href="${contextPath}/resources/css/flat-ui.css" rel="stylesheet">
    <%--<link href="${contextPath}/resources/css/toaster.css" rel="stylesheet">--%>
    <link href="${contextPath}/resources/css/chat.css" rel="stylesheet">
</head>
<body>
<c:if test="${pageContext.request.userPrincipal.name != null}">
    <form id="logoutForm" method="POST" action="${contextPath}/logout">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
    </form>
<div class="container">

    <div class="row">
        <nav class="navbar navbar-inverse navbar-embossed" role="navigation">
            <div class="collapse navbar-collapse" id="navbar-collapse-01">
                <h1>mChat Web Application</h1>
                <ul class="nav navbar-nav navbar-right">
                    <li><a onclick="document.forms['logoutForm'].submit()" href="#">Logout (${pageContext.request.userPrincipal.name})</a></li>
                </ul>
            </div><!-- /.navbar-collapse -->
        </nav><!-- /navbar -->
    </div>
    <div class="row">
        <div class="col-xs-4">
            <h4>Participants [10]</h4>
            <div class="share">
                <ul ng-repeat="participant in participants">
                    <li>
                        <%--<span class="input-icon fui-new" ng-show="participant.typing"></span>--%>
                        <span class="input-icon fui-user" ng-show="!participant.typing"></span>
                        <a href="" ng-click="privateSending(participant.username)">minh</a>
                    </li>
                    <li>
                            <%--<span class="input-icon fui-new" ng-show="participant.typing"></span>--%>
                        <span class="input-icon fui-user" ng-show="!participant.typing"></span>
                        <a href="" ng-click="privateSending(participant.username)">minh</a>
                    </li>
                </ul>
            </div>
        </div>
        <div class="col-xs-8 chat-box">
            <h4>Messages</h4>
            <div ng-repeat="message in messages">
                <small print-message>fsdfsdfsd</small>
            </div>
        </div>
    </div>
    <div class="row footer-chat-box">
        <div class="form-group">
            <span><small>You will send this message to <strong>{{sendTo}}</strong> (click a participant name to send a private message)</small></span>
            <input id="newMessageInput" type="text" class="form-control" placeholder="Write your message and hit enter..." ng-model="newMessage" ng-keyup="$event.keyCode == 13 ? sendMessage() : startTyping()"/>
        </div>
    </div>
</div>
</c:if>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="http://cdn.sockjs.org/sockjs-0.3.min.js"></script>
<script src="${contextPath}/resources/js/stomp.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
<script>
    //Create stomp client over sockJS protocol
    var socket = new SockJS("/ws");
    var stompClient = Stomp.over(socket);

    // Render price data from server into HTML, registered as callback
    // when subscribing to price topic
    function renderPrice(frame) {
        var prices = JSON.parse(frame.body);
        $('#price').empty();
        for(var i in prices) {
            var price = prices[i];
            $('#price').append(
                    $('<tr>').append(
                            $('<td>').html(price.code),
                            $('<td>').html(price.price.toFixed(2)),
                            $('<td>').html(price.timeStr)
                    )
            );
        }
    }

    // Callback function to be called when stomp client is connected to server
    var connectCallback = function() {
        stompClient.subscribe('/topic/price', renderPrice);
        stompClient.send('/app/newConnect');
    };

    // Callback function to be called when stomp client could not connect to server
    var errorCallback = function(error) {
        alert(error.headers.message);
    };

    // Connect to server via websocket
    stompClient.connect("guest", "guest", connectCallback, errorCallback);


    // Register handler for add button
    $(document).ready(function() {

        $('.add').click(function(e){
            e.preventDefault();
            var code = $('.new .code').val();
            var price = Number($('.new .price').val());
            var jsonstr = JSON.stringify({ 'code': code, 'price': price });
            stompClient.send("/app/addStock", {}, jsonstr);
            return false;
        });
    });

    // Register handler for remove all button
    $(document).ready(function() {
        $('.remove-all').click(function(e) {
            e.preventDefault();
            stompClient.send("/app/removeAllStocks");
            return false;
        });
    });
</script>
</body>
</html>

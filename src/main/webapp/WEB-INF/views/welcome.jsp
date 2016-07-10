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

<div class="container">

    <div class="row">
        <nav class="navbar navbar-inverse navbar-embossed" role="navigation">
            <div class="collapse navbar-collapse" id="navbar-collapse-01">
                <h1>Spring WebSocket Chat</h1>
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="websocket" target="_blank">Stats</a></li>
                    <li><a href="logout">Logout ({{username}})</a></li>
                </ul>
            </div><!-- /.navbar-collapse -->
        </nav><!-- /navbar -->
    </div>
    <div class="row">
        <div class="col-xs-4">
            <h4>Participants [{{participants.length}}]</h4>
            <div class="share">
                <ul ng-repeat="participant in participants">
                    <li>
                        <span class="input-icon fui-new" ng-show="participant.typing"></span>
                        <span class="input-icon fui-user" ng-show="!participant.typing"></span>
                        <a href="" ng-click="privateSending(participant.username)">{{participant.username}}</a>

                    </li>
                </ul>
            </div>
        </div>
        <div class="col-xs-8 chat-box">
            <h4>Messages</h4>
            <div ng-repeat="message in messages">
                <small print-message></small>
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

<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="${contextPath}/resources/js/bootstrap.min.js"></script>
</body>
</html>

<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<meta name="viewport" content="width=device-width, initial-scale=1">
<style>
.container {
  position: relative;
  width: 100%;
}

.image {
  display: block;
  width: 100%;
  height: 600px;
}

.overlay {
  position: absolute;
  bottom: 30%;
  left: 0;
  right: 0;
  background-color: #008CBA;
  overflow: hidden;
  width: 100%;
  height:0;
  transition: .5s ease;
}

.container:hover .overlay {
  bottom: 0;
  height: 100%;
}

.text {
  color: white;
  font-size: 20px;
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  -ms-transform: translate(-50%, -50%);
  text-align: center;
}
</style>
</head>
<body>

<!-- <h2>�Ϳ� ����</h2>
<p>������������ ���Ű��� ȯ���մϴ�.^^</p>-->

<div class="container">
  <img src="images/wedding_main01.jpg" width="800" height="600" alt="Avatar" class="image">
  <div class="overlay">
    <div class="text">�Ϳ� ����<br>������������ ���Ű��� ȯ���մϴ�.<br>
    Welcome WoW Wedding.co.kr</div>
  </div>
</div>

<!-- div id="mainbody">	<img src="images/wedding_main01.jpg"  width="800"></div-->
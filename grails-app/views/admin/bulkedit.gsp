<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews">
  <title>Admin panel - Bulk edit</title>
</head>

<body>
<h2>Admin bulk edit players ${game.value}</h2>

<fieldset class="form">
  <g:form action="bulksubmit" controller="admin" name="bulkForm" class="form-inline">
    <table class="table table-striped table-hover table-condensed">
    <thead>
    <tr>
      <td>name</td>
      <td>realname</td>
      <td>twitter</td>
      <td>twitch</td>
      <td>maxoplataId</td>
      <td>onlineId</td>
      <td>pictureUrl</td>
    </tr>
    </thead>
    <tbody>
    <g:each in="${players}" var="player">
      <tr>
        <td><g:link controller="rankings" action="player" params="[id:player.id]" target="_blank">${player.name}</g:link> </td>
        <td><g:textField name="name_${player.id}" value="${player.realname}"/></td>
        <td><g:textField name="name_${player.id}" value="${player.twitter}"/></td>
        <td><g:textField name="name_${player.id}" value="${player.twitch}"/></td>
        <td><g:textField name="name_${player.id}" value="${player.maxoplataId}"/></td>
        <td><g:textField name="name_${player.id}" value="${player.onlineId}"/></td>
        <td><g:textField name="name_${player.id}" value="${player.pictureUrl}"/></td>
      </tr>
    </g:each>
    </tbody>
    </table>
    <button type="submit" class="btn btn-primary">Submit</button>
  </g:form>
</fieldset>
<br/>
</body>
</html>
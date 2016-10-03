<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews"/>
  <g:if test="${game}">
  <title>Fighting Games World Rankings - ${game.value} Tournaments</title>
  </g:if>
  <g:else>
    <title>Fighting Games World Rankings - Tournaments</title>
  </g:else>
</head>

<body>
<h2 class="tournament">${game.value} Tournaments</h2>
${tournaments.size()} Tournaments Registered in results database.
<g:if test="${updateMessage}">
    <div class="alert alert-info alert-dismissable">
        <button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
        <g:message message="${updateMessage}"/>

    </div>
</g:if>
<div class="table-responsive">
  <table class="tablehead table-condensed" id="datatable">
    <thead>
    <tr class="stathead">
      <th>Name</th>
      <th>Type</th>
      <th>Date</th>
      <th>Location</th>
      <th>Game</th>
      <th>Weight</th>
      <th>Creator</th>
      <th>Ranking type</th>
      <g:if test="${game == be.bbr.sf4ranking.Version.SF5}">
      <th>Pro Tour</th>
      </g:if>
    </tr>
    </thead>
    <g:each in="${tournaments}" var="t">

      <tr>
        <td><g:link mapping="tournamentByName" controller="rankings" action="tournament" params="[name: t.name]">${t.name}</g:link></td>
        <td>${t.tournamentType?.value}</td>
        <td>${t.date?.format("yyyy-MM-dd")}</td>
        <td>
          <g:if test="${t.countryCode}">
            <g:link controller="rankings" action="tournaments" params="[country: t.countryCode.name()]">
              <g:img dir="images/countries" file="${t.countryCode.name().toLowerCase() + '.png'}" class="countryflag" />
              ${t.countryCode.name}
            </g:link>
          </g:if>
        </td>
        <td>${t.game?.name()}</td>
        <td>${t.weight}</td>
        <td>${t.creator}</td>
        <td>${t.weightingType}</td>
        <td>
          <g:if test="${game == be.bbr.sf4ranking.Version.SF5}">
            ${t.cptTournament?.value}
          </g:if>
        </td>
      </tr>
    </g:each>

  </table>
</div>

<div class="panel panel-info">
  <div class="panel-heading">
    <h3 class="panel-title">Filter</h3>
  </div>

  <div class="panel-body">
    <g:form name="filter" controller="rankings" action="tournaments" role="form" class="form-inline" method="get">
      <g:select name="country" from="${countries}" class="form-control"/>
      <g:select name="id" from="${versions}" class="form-control"/>
      <g:select name="type" from="${types}" class="form-control"/>
      <button type="submit" class="btn btn-primary">Submit</button>
    </g:form>
  </div>
</div>


<g:render template="/templates/prettify"/>

</body>
</html>
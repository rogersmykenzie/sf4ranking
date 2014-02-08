<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <meta name="layout" content="overviews"/>
  <r:require modules="bootstrap"/>
  <title>Street Fighter 4 World Ranking - ${player.name} results</title>
</head>

<body>
<center>
  <center>
  	<h6 class="player-heading">Street Fighter World Rankings</h6><span class="glyphicon glyphicon-flash"></span>
  	<h4 class="subtitle">rank.shoryuken.com</h4>
  </center>
<h1 class="player_name">${player.name}</h1>
<h3 class="world_rank">${player.rank}</h3>
<span class="glyphicon glyphicon-flash"></span><span class="world_rank_title"> Street Fighter World Rank </span><span class="glyphicon glyphicon-flash"></span>
<dl class="dl-horizontal player_details">
  <dt>Country</dt>
  <dd>
    ${player.countryCode?.name}
    <g:if test="${player.countryCode != null}">
      <g:link controller="rankings" action="index" params="[country: player.countryCode.name()]">
        <g:img dir="images/countries" file="${player.countryCode.name().toLowerCase() + '.png'}"
               alt="Find players from ${player.countryCode.name}"/>
      </g:link>
    </g:if>

  </dd>
  <dt>Score</dt>
  <dd>${player.score}</dd>
  <dt>Character(s)</dt>
  <dd>
    <g:each in="${chars}" var="pchar">
      <g:link action="index" controller="rankings" params="[pchar: pchar.name()]">${pchar.value}</g:link>
    </g:each>
  </dd>
  <dt>Skill Weight</dt>
  <dd>${player.skill}</dd>

</dl>
<h3 class="tournaments">Tournament placings<small> found [${results.size()}] SSFIV:AE ver. 2012 rankings for </small>${player.name}</h3>
</center>

<div class="table-responsive">
  <table class="table table-striped table-hover">
    <thead>
    <tr>
      <td>Tournament</td>
      <td>Type</td>
      <td>Ranking</td>
      <td>Date</td>
      <td>Character</td>
      <td>Points</td>
    </tr>
    </thead>
    <g:each in="${results}" var="result">
      <tr>
        <td><g:link controller="rankings" action="tournament" params="['id': result.tid]" title="View tournament">${result.tname}</g:link></td>
        <td>${result.ttype}</td>
        <td>${result.tplace}</td>
        <td>${result.tdate}</td>
        <td>
          <g:if test="${result.tchar}">
            <g:link action="index" controller="rankings" params="[pchar: result.tchar]">
              <g:img dir="images/chars" file="${result.tchar + '.png'}" width="22" height="25" alt="${result.tchar}" title="${result.tchar}"/>
              ${result.tcharname}
            </g:link>
          </g:if>

        </td>
        <td>${result.tscore}</td>
      </tr>
    </g:each>
  </table>
</div>

<g:if test="${session.user != null}">
  <g:link controller="admin" action="selectPlayerVideos" params="['id': player.id]">[Update videos as admin]</g:link>
</g:if>

<g:if test="${player.videos}">
  <h2>Player videos <small>found ${player.videos.size()} videos</small></h2>
  <g:each in="${player.videos}" var="video">
    <section class="row">
      <div class="span6">
        <div class="flex-video widescreen"><iframe width="560" height="315" src="//www.youtube.com/embed/${video}" frameborder="0"
                                                   allowfullscreen></iframe></div>
      </div>

    </section>
  </g:each>
</g:if>
</body>
</html>
<%@ page import="be.bbr.sf4ranking.RankingType; be.bbr.sf4ranking.Region; org.apache.shiro.SecurityUtils; be.bbr.sf4ranking.Version" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="artificial"/>
    <title>SRK data - ${player.name} results</title>
</head>

<body>
<div style="text-align: center;">
    <h1 class="player_name">${player.name}</h1>
</div>

<div class="row">
    <div class="col-md-8">
        <dl class="dl-horizontal player_details">
            <dt>Country</dt>
            <dd>
                <g:if test="${player.countryCode != null}">
                    <g:link controller="rankings" action="rank" params="[country: player.countryCode.name()]">
                        ${player.countryCode?.name}
                        <g:img dir="images/countries" file="${player.countryCode.name().toLowerCase() + '.png'}"
                               alt="Find players from ${player.countryCode.name}"/>
                    </g:link>
                </g:if>&NonBreakingSpace;
            </dd>
            <dt>Full name</dt>
            <dd>
                <g:if test="${player.realname}">
                    ${player.realname}
                </g:if>
                <g:else>
                    <a href="#" data-toggle="tooltip" data-placement="top"
                       title="If you want to add your name to this page just share it on Twitter with the button below and we will favorite it when we linked it">(?)</a>
                </g:else>
            </dd>

            <dt>Top player in</dt>
            <dd>
                <g:if test="${topGames}">
                    <g:each in="${topGames}" var="topgame">
                        <g:link action="rank" controller="rankings"
                                params="[id: topgame.name()]">${topgame.name()}</g:link>
                    </g:each>
                </g:if>
            </dd>

            <dt>&nbsp;</dt><dd></dd>


            <dt>Controller</dt>
            <dd>
                <g:if test="${player.hardware}">
                    <a href="${player.hardware.directLink}" target="_blank">
                        ${player.hardware.shortname}
                    </a>
                </g:if>
                <g:else>
                    <a href="#" data-toggle="tooltip" data-placement="top"
                       title="Know the controller ${player.name} uses? Tweet it to us using page tweet!">(?)</a>
                </g:else>
            </dd>
            <dt>Teams(s)</dt>
            <dd>
                <g:if test="${player.teams}">
                    <g:each in="${player.teams}" var="team">
                        <g:link mapping="teamByName" action="team" controller="rankings"
                                params="[name: team.name]">${team.name}</g:link>
                    </g:each>
                </g:if>
                <g:else>
                    <a href="#" data-toggle="tooltip" data-placement="top"
                       title="You can add this player to a team by sharing this page on Twitter and mentioning the team">(?)</a>
                </g:else>
            </dd>
            <dt>Known for</dt>
            <dd>
                <g:if test="${allGames}">
                    <g:each in="${allGames}" var="knowngame">
                        <g:link action="rank" controller="rankings"
                                params="[id: knowngame.name()]">${knowngame.name()}</g:link>
                    </g:each>
                </g:if>
            </dd>

            <dt>Follow</dt>
            <dd>
                <g:if test="${player.twitter}">
                    <g:render template="/templates/follow" model="[twitter: player.twitter]"/>&NonBreakingSpace;
                </g:if>
                <g:else>
                    <a href="#" data-toggle="tooltip" data-placement="top"
                       title="If you want to add your twitter handle to this page, share it on Twitter with the button below and we will favorite it when we linked it">(?)</a>
                </g:else>
            </dd>
            <g:if test="${player.twitch}">
                <dt>Twitch Stream</dt>
                <dd>
                    <a href="https://www.twitch.tv/${player.twitch}" target="_blank">${player.twitch}</a>
                </dd>
            </g:if>
            <g:if test="${player.smashId}">
                <dt>Smash ID</dt>
                <dd>
                    ${player.smashId}
                </dd>
            </g:if>

            <g:if test="${player.hasRanking(Version.SF5) && player.cptScore() > 0}">
                <dt>CPT score (rank) <a href="#" data-toggle="tooltip" data-placement="top"
                                        title="Global CPT score">(?)</a></dt>
                <dd>
                    <g:link action="cpt" controller="rankings">
                        ${player.cptScore()} (${player.findCptRanking(Region.GLOBAL)?.rank})
                    </g:link>
                </dd>
                <dt>CPT Qualified <a href="#" data-toggle="tooltip" data-placement="top"
                                     title="Directly qualified for CPT">(?)</a></dt>
                <dd>
                    ${player.cptGlobal()?.qualified ? "Qualified" : "Not qualified"}
                </dd>
                <dt>CPT Region scores <a href="#" data-toggle="tooltip" data-placement="top"
                                         title="Scores for regions Asia / Europe / Latin America / North America">(?)</a>
                </dt>
                <dd>
                    ${player.findCptRanking(Region.AO)?.score ?: "-"} / ${player.findCptRanking(Region.EU)?.score ?: "-"} / ${player.findCptRanking(Region.LA)?.score ?: "-"} / ${player.findCptRanking(Region.NA)?.score ?: "-"}
                </dd>
                <dt>CPT Region ranks <a href="#" data-toggle="tooltip" data-placement="top"
                                        title="Ranks for regions Asia / Europe / Latin America / North America">(?)</a>
                </dt>
                <dd>
                    ${player.findCptRanking(Region.AO)?.rank ?: "-"} / ${player.findCptRanking(Region.EU)?.rank ?: "-"} / ${player.findCptRanking(Region.LA)?.rank ?: "-"} / ${player.findCptRanking(Region.NA)?.rank ?: "-"}
                </dd>
                <dt>CPT RF <a href="#" data-toggle="tooltip" data-placement="top"
                              title="Is this player qualified for the CPT Regional Finals?">(?)</a></dt>
                <dd>
                    ${player.findCptRanking(Region.AO)?.qualified ? "AO" : "-"} / ${player.findCptRanking(Region.EU)?.qualified ? "EU" : "-"} / ${player.findCptRanking(Region.LA)?.qualified ? "LA" : "-"} / ${player.findCptRanking(Region.NA)?.qualified ? "NA" : "-"}
                </dd>
            </g:if>
            <dt>Compare</dt>
            <dd>
                <g:link controller="stats" action="compare" params="[p1: player.id]">versus</g:link>
            </dd>

            <g:if test="${player.maxoplataId}">
                <dt>Match details <a href="#" data-toggle="tooltip" data-placement="top"
                                     title="Link to the player profile on maxoplata.net to find more data on player matches and brackets">(?)</a>
                </dt>
                <dd>
                    <a href="http://www.maxoplata.net/player/${player.maxoplataId}"
                       target="_blank">maxoplata.net</a>
                </dd>
            </g:if>

            <dt>Share page</dt>
            <dd>
                <g:render template="/templates/share"/>&NonBreakingSpace;
            </dd>
            <g:if test="${player.description}">
                <dt>Background
                <a href="#" data-toggle="tooltip" data-placement="top"
                   title="Info from Liquipedia.net that contains detailed esports player info and tournament data">(?)</a>
                </dt>
                <dd>
                    <div>
                        <g:message message="${player.description.take(700)}"/>
                        <g:if test="${player.description.size() >700}"> ...</g:if>
                    </div>
                    <br/>
                    <p>
                        Learn more about ${player.name} at <a href="http://liquipedia.net/fighters/${player.liquipedia}" target="_blank">Liquipedia Fighters!</a>
                    </p>
                </dd>
            </g:if>

        </dl>
    </div>

    <div class="col-md-4">
        <g:if test="${player.pictureUrl}">
            <img src="${player.pictureUrl}" class="img-responsive"/>
            <g:if test="${player.pictureCopyright}">
                (c) ${player.pictureCopyright}
            </g:if>
            <g:else>
                <p class="text-muted"><small>
                    <a href="#" data-toggle="tooltip" data-placement="top"
                       title="(no copyright known, tweet this page with your claim)">(copyright)</a>
                </small>
                </p>
            </g:else>
        </g:if>
        <g:else>
            <p class="text-muted">
                <small>
                    (No image found yet, if you have one please tweet this page with URL to image)</small>
            </p>
        </g:else>
        <br/>
        <script id="mNCC" language="javascript">
            medianet_width = "468";
            medianet_height = "60";
            medianet_crid = "449988581";
            medianet_versionId = "3111299";
        </script>
        <script src="//contextual.media.net/nmedianet.js?cid=8CU54R87O"></script>
    </div>
</div>

<ul class="nav nav-tabs">
    <li class="active"><a href="#overview" data-toggle="tab">Overview</a></li>
    <g:each in="${results}" var="ranking" status="index">
        <li><a href="#${ranking.key.name()}" data-toggle="tab">${ranking.key.name()} <span
                class="badge">${ranking.value.size()}</span></a></li>
    </g:each>
%{--
        <li><a href="#videos" data-toggle="tab">Videos <span class="badge">${player.videos.size()}</span></a></li>
--}%
</ul>


<div id='content' class="tab-content">
    <div class="tab-pane active" id="overview">
        <h3 class="tournaments">Tournament placings <small>found ${player.rankings.size()} games for</small> ${player.name} <small>in ${totalResults} results</small>
        </h3>

        <div class="table-responsive">
            <table class="tablehead" id="infotable">
                <thead>
                <tr class="stathead">
                    <th>Game</th>
                    <th>Rank</th>
                    <th>Lifetime rank</th>
                    <th>Trending rank</th>
                    <th>Current score</th>
                    <th>Lifetime score</th>
                    <th>Trending score</th>
                    <th>Main Team</th>
                    <th>Weight</th>
                    <th>Tournaments played</th>
                </tr>
                </thead>
                <g:each in="${player.rankings}" var="ranking" status="index">
                    <g:if test="${results[ranking.game] != null}">
                        <tr>

                            <td>
                                ${ranking.game.value}
                            </td>
                            <td>
                                <g:link controller="rankings" action="rank"
                                        params="[id: ranking.game.name(), rankingType: RankingType.ACTUAL.name()]">
                                    ${ranking.rank}
                                </g:link>
                            </td>
                            <td>
                                <g:link controller="rankings" action="rank"
                                        params="[id: ranking.game.name(), rankingType: RankingType.ALLTIME.name()]">
                                    ${ranking.totalRank}
                                </g:link>
                            </td>
                            <td>
                                <g:link controller="rankings" action="rank"
                                        params="[id: ranking.game.name(), rankingType: RankingType.TRENDING.name()]">
                                    ${ranking.trendingRank}
                                </g:link>
                            </td>
                            <td>${ranking.score}</td>
                            <td>${ranking.totalScore}</td>
                            <td>${ranking.trendingScore}</td>
                            <td>
                                <g:each in="${ranking.mainCharacters}" var="mainCharacter">
                                    <g:link action="rank" controller="rankings"
                                            params="[pchar: mainCharacter.name(), id: ranking.game.name()]"
                                            data-toggle="tooltip" data-placement="top"
                                            title="Filter on ${mainCharacter.name()}">
                                        <g:set var="prepend"
                                               value="${Version.generalize(ranking.game) == Version.USF4 ? "thumb_" : ""}"/>
                                        <g:img dir="images/chars/${Version.generalize(ranking.game).name().toLowerCase()}"
                                               file="${prepend + mainCharacter.name().toLowerCase() + '.png'}"
                                               height="25" class="charimg"/>
                                    </g:link>
                                </g:each>

                            </td>
                            <td>${ranking.skill}</td>
                            <td>
                                <g:link action="player" controller="rankings" params="[id: player.id]"
                                        fragment="${ranking.game.name()}" data-toggle="tab">
                                    ${results[ranking.game]?.size()} (see results)
                                </g:link>
                            </a>
                            </td>
                        </tr>
                    </g:if>
                </g:each>
            </table>
        </div>
    </div>


    <g:each in="${results}" var="ranking" status="index">
        <div class="tab-pane" id="${ranking.key.name()}">
            <h3 class="tournaments">Tournament placings <small>found [${ranking.value.
                    size()}] ${ranking.key} tournaments for</small> ${player.name}
            </h3>

            <div class="table-responsive">
                <table class="tablehead" id="datatable_${index}">
                    <thead>
                    <tr class="stathead">
                        <th>Tournament</th>
                        <th>Type</th>
                        <th>Ranking</th>
                        <th>Date</th>
                        <th>Team</th>
                        <th>Relative Points</th>
                        <th>Base Points</th>
                        <g:if test="${ranking.key == Version.SF5}">
                            <th>CPT Points</th>
                        </g:if>
                        <g:if test="${SecurityUtils.subject.isPermitted("player")}">
                            <th>Edit</th>
                        </g:if>
                    </tr>
                    </thead>
                    <g:each in="${ranking.value}" var="result">
                        <tr>
                            <td><g:link mapping="tournamentByName" controller="rankings" action="tournament"
                                        params="[name: result.tname]"
                                        title="View tournament">${result.tname}</g:link></td>
                            <td>${result.ttype}</td>
                            <td>${result.tplace}</td>
                            <td>${result.tdate}</td>
                            <td>
                                <g:if test="${result.tteams}">
                                    <g:each in="${result.tteams}" var="tteam" status="rowidx">
                                        <g:if test="${rowidx > 0}">
                                            /
                                        </g:if>
                                        <g:each in="${tteam.pchars}" var="tchar">
                                            <g:link action="rank" controller="rankings"
                                                    params="[pchar: tchar.characterType.name(), id: ranking.key.name(), pfiltermain: 'on']"
                                                    data-toggle="tooltip" data-placement="top"
                                                    title="Filter on ${tchar.characterType.name()}">
                                                <g:img dir="images/chars/${Version.generalize(ranking.key).name().toLowerCase()}"
                                                       file="${tchar.characterType.name().toLowerCase() + '.png'}"
                                                       width="18" height="20"
                                                       class="charimg"/>
                                            </g:link>
                                        </g:each>
                                    </g:each>
                                </g:if>
                            </td>
                            <td>${result.tscore}</td>
                            <td>${result.tbasescore}</td>
                            <g:if test="${ranking.key == Version.SF5}">
                                <td>${result.tcpt}</td>
                            </g:if>
                            <g:if test="${SecurityUtils.subject.isPermitted("player")}">
                                <td><g:link controller="result" action="show"
                                            params="[id: result.resultid]">[Update result as admin]</g:link></td>
                            </g:if>
                        </tr>
                    </g:each>
                </table>
            </div>
        </div>
    </g:each>






    <g:if test="${SecurityUtils.subject.isPermitted("player")}">
        <div class="alert alert-info top10box">
            <g:link controller="player" action="show" params="['id': player.id]">[See player]</g:link>
            <g:link controller="player" action="edit" params="['id': player.id]">[Update player]</g:link>
            <g:link controller="admin" action="split" params="['id': player.id]">[Split player]</g:link>
            <g:link controller="admin" action="merge" params="['id': player.id]">[Merge player]</g:link>
        </div>
    </g:if>

</div>

%{--<div class="row top10box" align="center">
    <script type="text/javascript">
        amzn_assoc_placement = "adunit0";
        amzn_assoc_search_bar = "false";
        amzn_assoc_tracking_id = "capcomkindle-20";
        amzn_assoc_ad_mode = "search";
        amzn_assoc_ad_type = "smart";
        amzn_assoc_marketplace = "amazon";
        amzn_assoc_region = "US";
        amzn_assoc_title = "Kindle books";
        amzn_assoc_default_search_phrase = "capcom game";
        amzn_assoc_default_category = "KindleStore";
        amzn_assoc_linkid = "30850ec2afc5d728b020a4c3e6114822";
        amzn_assoc_default_browse_node = "133140011";
    </script>
    <script src="//z-na.amazon-adsystem.com/widgets/onejs?MarketPlace=US"></script>
</div>--}%
<center>
    <div class="row top10box" style="margin-top: 20px" align="center">
        <div class="panel panel-primary">
            <div class="panel-body">
                <div class="col-md-3">
                    <g:link url="https://displate.com/displate/291193?merch=5b5a0ec49ef2b">
                        <g:img dir="images/displate" file="cammy_small.png" class="img-responsive"/>
                    </g:link>
                </div>

                <div class="col-md-3">
                    <g:link url="https://displate.com/displate/284559?merch=5b5a0ec49ef2b">
                        <g:img dir="images/displate" file="chun_small.png" class="img-responsive"/>
                    </g:link>
                </div>

                <div class="col-md-3">
                    <g:link url="https://displate.com/displate/259832?merch=5b5a0ec49ef2b">
                        <g:img dir="images/displate" file="akuma_small.png" class="img-responsive"/>
                    </g:link>

                </div>

                <div class="col-md-3">
                    <g:link url="https://displate.com/displate/149208?merch=5b5a0ec49ef2b">
                        <g:img dir="images/displate" file="sf_mini_small.png" class="img-responsive"/>
                    </g:link>
                </div>
            </div>
        </div>
    </div>
</center>

%{--        <div class="tab-pane" id="videos">
            <g:if test="${player.videos}">
                <h2>Player videos <small>found ${player.videos.size()} videos</small></h2>

                <div class="row">
                    <g:each in="${player.videos}" var="video">
                        <div class="col-xs-6 col-md-3">
                            <a href="#" class="thumbnail">
                                <div class="flex-video widescreen"><iframe src="//www.youtube.com/embed/${video}" frameborder="0"
                                                                           allowfullscreen></iframe></div>
                            </a>
                        </div>
                    </g:each>
                </div>
            </g:if></div>--}%

<script>
    // Javascript to enable link to tab
    var url = document.location.toString();
    if (url.match('#')) {
        $('.nav-tabs a[href="#' + url.split('#')[1] + '"]').tab('show');
    }

    // Change hash for page-reload
    $('.nav-tabs a').on('shown.bs.tab', function (e) {
        window.location.hash = e.target.hash;
    })
</script>
</body>
</html>
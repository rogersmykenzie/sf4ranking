import be.bbr.sf4ranking.CharacterType
import be.bbr.sf4ranking.Version
import groovy.json.JsonSlurper

def sf5tournaments = new JsonSlurper().parse("http://rank.shoryuken.com/api/tournament/game/SF5".toURL())
def premiers = sf5tournaments.findAll { it.cpt == "PREMIER" || it.cpt == "EVO" || it.cpt == "REGIONAL_FINAL" }
def rankings = sf5tournaments.findAll { it.cpt == "RANKING" || it.cpt == "ONLINE_EVENT" }

def winners = { tournaments ->
    tournaments.findResults {
        def tournament = new JsonSlurper().parse("http://rank.shoryuken.com/api/tournament/id/$it.id".toURL())
        return tournament.results.find { it.place == 1}?.characters?.flatten()
    }.flatten()
}

def sf5chars = CharacterType.values().findAll { it.game == Version.SF5 }.collect { it.name() }

def premierwinners = winners(premiers)
def rankingwinners = winners(rankings)
println "Premier winners: " + premierwinners.countBy { it }
println "Ranking winners: " + rankingwinners.countBy { it }

println "Never won premier: " + sf5chars.findAll { !premierwinners.contains(it) }
println "Never won ranking: " + sf5chars.findAll { !rankingwinners.contains(it) }


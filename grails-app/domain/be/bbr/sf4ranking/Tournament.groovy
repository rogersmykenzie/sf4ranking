package be.bbr.sf4ranking

import org.apache.shiro.SecurityUtils


class Tournament
{

    static constraints = {
        name nullable: false, unique: true
        weight editable: false
        date nullable: false
        countryCode nullable: true
        tournamentType nullable: true
        tournamentFormat nullable: false
        weightingType nullable: false
        game nullable: false
        codename nullable: true, unique: true, editable: false
        videos nullable: true, unique: false
        challonge nullable: true
        ranked nullable: false
        coverage nullable: true
        creator nullable: true
        cptTournament nullable: true
        finished nullable: false
        region nullable: true
        event nullable: true
    }

    static mapping = {
        game index: 'game_idx_t'
        countryCode index: 'country_idx'
        codename index: 'codename_t_index'
    }

    String name
    String codename
    Long weight
    Date date
    CountryCode countryCode
    TournamentType tournamentType
    TournamentFormat tournamentFormat = TournamentFormat.UNKNOWN
    Version game = Version.UNKNOWN
    WeightingType weightingType = WeightingType.AUTO
    CptTournament cptTournament = null
    String challonge
    Boolean ranked = true
    Boolean finished = true
    String coverage = null
    String creator
    Region region = Region.UNKNOWN

    Event event

    static hasMany = [videos: String, results: Result]

    def beforeInsert() {
        codename = name.toUpperCase()
        if (!creator) creator = SecurityUtils.subject?.principal?.toString()
    }

    def beforeUpdate() {
        codename = name.toUpperCase()
    }

    public String toString() {
        def props = []
        if (name) props << name
        if (countryCode) props << countryCode
        return props.join(", ")
    }
}

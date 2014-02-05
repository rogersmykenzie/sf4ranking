package be.bbr.sf4ranking

import groovy.transform.ToString

@ToString(includePackage = false, ignoreNulls = true)
class Tournament
{

    static constraints = {
        name nullable: false, unique: true
        weight range: 1..100
        date nullable: false
        countryCode nullable: true
        tournamentType nullable: true
        tournamentFormat nullable: false
        game nullable: false
        codename nullable: true, unique: true
        videos nullable: true, unique: false
    }

    String name
    String codename
    Long weight
    Date date
    CountryCode countryCode
    TournamentType tournamentType
    TournamentFormat tournamentFormat = TournamentFormat.UNKNOWN
    Version game = Version.UNKNOWN

    static hasMany = [videos: String, results: Result]

    def beforeInsert() {
        codename = name.toUpperCase()
    }
}

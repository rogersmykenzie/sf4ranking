package be.bbr.sf4ranking

import org.apache.shiro.SecurityUtils


class Event
{

    static constraints = {
        name nullable: false, unique: true
        weight editable: false
        date nullable: false
        countryCode nullable: true
        codename nullable: true, unique: true, editable: false
        creator nullable: true
        region nullable: true
        host nullable: true
        twitter nullable: true
    }

    static mapping = {
        countryCode index: 'country_idx'
        codename index: 'codename_t_index'
    }

    String name
    String codename
    Long weight
    Date date
    CountryCode countryCode
    String creator
    Region region = Region.UNKNOWN
    String host
    String twitter

    static hasMany = [tournaments: Tournament]

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

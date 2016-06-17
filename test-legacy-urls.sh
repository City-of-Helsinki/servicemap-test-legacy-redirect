source ./assert-redirect.sh

ORIGIN_BASEURL=localhost:9001/rdr
ORIGIN_FI=$ORIGIN_BASEURL

SM_FI=palvelukartta.hel.fi
SM_SV=servicekarta.hel.fi
SM_EN=servicemap.hel.fi

# lang parameter
asr $ORIGIN_FI/?lang=fi $SM_FI
asr $ORIGIN_FI/?lang=se $SM_SV
asr $ORIGIN_FI/?lang=en $SM_EN

# full text search
SEARCH_QUERY="a+b+c+de"
SEARCH_QUERY2="a%20b%20c%20de"
SEARCH_QUERY_WITH_AMPER_AND_QUESTION_AND_SLASH="a+bc%2F%3F%26"

asr "$ORIGIN_FI/?search=$SEARCH_QUERY" \
    "$SM_FI/search?q=$SEARCH_QUERY"

asr "$ORIGIN_FI?search=$SEARCH_QUERY" \
    "$SM_FI/search?q=$SEARCH_QUERY"

asr "$ORIGIN_FI/?search=$SEARCH_QUERY2" \
    "$SM_FI/search?q=$SEARCH_QUERY"

asr "$ORIGIN_FI?search=$SEARCH_QUERY2" \
    "$SM_FI/search?q=$SEARCH_QUERY"

asr "$ORIGIN_FI?search=$SEARCH_QUERY_WITH_AMPER_AND_QUESTION_AND_SLASH" \
    "$SM_FI/search?q=$SEARCH_QUERY_WITH_AMPER_AND_QUESTION_AND_SLASH"

asr "$ORIGIN_FI/?search=$SEARCH_QUERY&lang=se" \
    "$SM_SV/search?q=$SEARCH_QUERY"

asr "$ORIGIN_FI?search=$SEARCH_QUERY&lang=se" \
    "$SM_SV/search?q=$SEARCH_QUERY"

asr "$ORIGIN_FI/?search=$SEARCH_QUERY2&lang=se" \
    "$SM_SV/search?q=$SEARCH_QUERY"

asr "$ORIGIN_FI?search=$SEARCH_QUERY2&lang=se" \
    "$SM_SV/search?q=$SEARCH_QUERY"

asr "$ORIGIN_FI/?lang=en&search=$SEARCH_QUERY" \
    "$SM_EN/search?q=$SEARCH_QUERY"

asr "$ORIGIN_FI?lang=en&search=$SEARCH_QUERY" \
    "$SM_EN/search?q=$SEARCH_QUERY"

asr "$ORIGIN_FI/?lang=en&search=$SEARCH_QUERY2" \
    "$SM_EN/search?q=$SEARCH_QUERY"

asr "$ORIGIN_FI?lang=en&search=$SEARCH_QUERY2" \
    "$SM_EN/search?q=$SEARCH_QUERY"

# city
# TODO: implement parameter in servicemap UI

asr "$ORIGIN_FI/?search=kallio&city=helsinki" \
    "$SM_FI/search?q=kallio&municipality=helsinki"

asr "$ORIGIN_FI/?search=kallio&city=espoo" \
    "$SM_FI/search?q=kallio&municipality=espoo"

asr "$ORIGIN_FI/?search=kallio&city=vantaa&lang=se" \
    "$SM_SV/search?q=kallio&municipality=vantaa"

asr "$ORIGIN_FI/?search=kallio&city=kauniainen" \
    "$SM_FI/search?q=kallio&municipality=kauniainen"

asr "$ORIGIN_FI/?search=kallio&lang=en&city=all" \
    "$SM_EN/search?q=kallio&municipality=all"

# theme
asr "$ORIGIN_FI/?theme=8511+8571" \
    "$SM_FI/unit?services=8511,8571"

asr "$ORIGIN_FI/?theme=8511+8571&lang=se" \
    "$SM_SV/unit?services=8511,8571"

asr "$ORIGIN_FI/?lang=en&theme=8511+8571" \
    "$SM_EN/unit?services=8511,8571"

# theme + search
# TODO: implement parameter in servicemap UI

asr "$ORIGIN_FI/?theme=8511+8571&search=puisto" \
   "$SM_FI/search?q=puisto&services=8551,8571"
asr "$ORIGIN_FI/?theme=8511+8571&lang=se&search=parken" \
   "$SM_SV/search?q=parken&services=8551,8571"
asr "$ORIGIN_FI/?lang=en&theme=8511+8571&search=park" \
   "$SM_EN/search?q=park&services=8551,8571"

# distance + address
# TODO: implement distance parameter in servicemap UI
# TODO: test pathologic street addresses !

asr "$ORIGIN_FI/?distance=250&address=Mannerheimintie+5%2c+Helsinki" \
    "$SM_FI/address/helsinki/mannerheimintie/5?radius=250"

# service details
for service in all health education rescue electoraldistrict; do
        asr "$ORIGIN_FI/?address=Mannerheimintie+5%2c+Helsinki&service=$service" \
            "$SM_FI/address/helsinki/mannerheimintie/5#!service-details"
done

# id
asr "$ORIGIN_FI/?id=6500" \
    "$SM_FI/unit/6500"

asr "$ORIGIN_FI/?id=6500&lang=se" \
    "$SM_SV/unit/6500"

asr "$ORIGIN_FI/?id=6500&lang=en" \
    "$SM_EN/unit/6500"

# output: not implemented
# organization: not implemented

# ------------------------------------------------------------------------------

# region -- TODO: extract regions from html
# TODO: needs indexing of regions in search ...

# C235 = kauniainen
# C91 = helsinki
# C49 = espoo
# C92 = vantaa

# partofhelsinki*etutoolo doesn't work
# city*espoo works

# 91   : Helsingin kaupunki
# 49   : Espoon kaupunki
# 92   : Vantaan kaupunki
# 235  : Kauniaisten kaupunki
# 1000 : Valtion IT-palvelukeskus, Suomi.fi-toimitus
# 1001 : HUS-kuntayhtymä
# 1002 : Helsingin markkinointi Oy
# 1004 : Helsingin seudun ympäristöpalvelut HSY
# 1005 : Palvelukartan toimitus
# 1007 : JLY Jätelaitosyhdistys ry
# 1008 : Norsk Elbilforening, sähköautojen latauspisteet
# 1009 : Ulkoisen toimipisterekisterin käyttäjäyhteisö
# 1010 : Jyväskylän yliopisto, LIPAS Liikuntapaikat.fi
# 1012 : Espoon seudun koulutuskuntayhtymä Omnia

asr "$ORIGIN_FI/?search=laboratorio&organization=1001" \
    "$SM_FI/search?q=laboratorio&organization=1001"

# ------------------------------------------------------------------------------

# embedded parameters
# addresslocation

asr "$ORIGIN_FI/embed/embed.aspx?addresslocation=urho%20kekkosenkatu%206,%20helsinki&addresslabel=Tavastia" \
    "$SM_FI/embed/address/helsinki/urho+kekkosenkatu/6"

asr "$ORIGIN_FI/embed/embed.aspx?addresslocation=urho%20kekkosenkatu%206,%20helsinki&addresslabel=Tavastia&language=en" \
    "$SM_EN/embed/address/helsinki/urho+kekkosenkatu/6"

# addresslabel         : not implemented 
# ui                   : not implemented
# locations            : not implemented
# poie, poin, poilabel : not implemented
# col (color)          : not implemented

# --------------------------------------------

print_error_count

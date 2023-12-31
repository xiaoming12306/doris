--from clickbench table hits
CREATE TABLE IF NOT EXISTS  orc_s3_case2 (
    counterid int not null, 
    eventdate int not null, 
    userid bigint not null, 
    eventtime int not null, 
    watchid bigint not null, 
    javaenable smallint not null,
    title string not null,
    goodevent smallint not null,
    clientip int not null,
    regionid int not null,
    counterclass smallint not null,
    os smallint not null,
    useragent smallint not null,
    url string not null,
    referer string not null,
    isrefresh smallint not null,
    referercategoryid smallint not null,
    refererregionid int not null,
    urlcategoryid smallint not null,
    urlregionid int not null,
    resolutionwidth smallint not null,
    resolutionheight smallint not null,
    resolutiondepth smallint not null,
    flashmajor smallint not null,
    flashminor smallint not null,
    flashminor2 string not null,
    netmajor smallint not null,
    netminor smallint not null,
    useragentmajor smallint not null,
    useragentminor varchar(255) not null,
    cookieenable smallint not null,
    javascriptenable smallint not null,
    ismobile smallint not null,
    mobilephone smallint not null,
    mobilephonemodel string not null,
    params string not null,
    ipnetworkid int not null,
    traficsourceid smallint not null,
    searchengineid smallint not null,
    searchphrase string not null,
    advengineid smallint not null,
    isartifical smallint not null,
    windowclientwidth smallint not null,
    windowclientheight smallint not null,
    clienttimezone smallint not null,
    clienteventtime int not null,
    silverlightversion1 smallint not null,
    silverlightversion2 smallint not null,
    silverlightversion3 int not null,
    silverlightversion4 smallint not null,
    pagecharset string not null,
    codeversion int not null,
    islink smallint not null,
    isdownload smallint not null,
    isnotbounce smallint not null,
    funiqid bigint not null,
    originalurl string not null,
    hid int not null,
    isoldcounter smallint not null,
    isevent smallint not null,
    isparameter smallint not null,
    dontcounthits smallint not null,
    withhash smallint not null,
    hitcolor char not null,
    localeventtime int not null,
    age smallint not null,
    sex smallint not null,
    income smallint not null,
    interests smallint not null,
    robotness smallint not null,
    remoteip int not null,
    windowname int not null,
    openername int not null,
    historylength smallint not null,
    browserlanguage string not null,
    browsercountry string not null,
    socialnetwork string not null,
    socialaction string not null,
    httperror smallint not null,
    sendtiming int not null,
    dnstiming int not null,
    connecttiming int not null,
    responsestarttiming int not null,
    responseendtiming int not null,
    fetchtiming int not null,
    socialsourcenetworkid smallint not null,
    socialsourcepage string not null,
    paramprice bigint not null,
    paramorderid string not null,
    paramcurrency string not null,
    paramcurrencyid smallint not null,
    openstatservicename string not null,
    openstatcampaignid string not null,
    openstatadid string not null,
    openstatsourceid string not null,
    utmsource string not null,
    utmmedium string not null,
    utmcampaign string not null,
    utmcontent string not null,
    utmterm string not null,
    fromtag string not null,
    hasgclid smallint not null,
    refererhash bigint not null,
    urlhash bigint not null,
    clid int not null
)  
DUPLICATE KEY (CounterID, EventDate, UserID, EventTime, WatchID) 
DISTRIBUTED BY HASH(UserID) BUCKETS 16
PROPERTIES ("replication_num"="1");

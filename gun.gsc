main()
{
    // restore scr_game_hardpoints value when game ends
    if (getdvar("g_gametype") == "gun")
    {
        level.saved_hardpoints_dvar = getdvar("scr_game_hardpoints");
    }

    // replace gun game weapon pool
    replacefunc(maps\mp\gametypes\gun::setguns, ::setguns_stub);
    replacefunc(maps\mp\gametypes\gun::isdedicatedmeleeweapon, ::isdedicatedmeleeweapon_stub);
}

init()
{
    if (getdvar("g_gametype") == "gun")
    {
        thread reset_hardpoints_dvar();
    }
    level thread onPlayerConnect();
}

reset_hardpoints_dvar()
{
    level waittill("game_ended");
    setdvar("scr_game_hardpoints", level.saved_hardpoints_dvar);
}

guninfo( gun_name, attachment_name, attachment2 )
{
    new_gun = spawnstruct();
    new_gun.basename = gun_name;
    new_gun.altfireonly = 0;

    if (attachment_name == attachment2)
    {
        attachment2 = "none"
    }
    //test
    new_gun.fullname = maps\mp\gametypes\_class::buildweaponname( gun_name, attachment_name, attachment2, randomInt(9), ["specialty_bling"] );
    //new_gun.fullname = maps\mp\gametypes\_class::buildweaponnamecamo( new_gun.fullname, randomInt(44) );
    level.gun_guns[level.gun_guns.size] = new_gun;
}

setguns_stub()
{
    last_kill_shovel_1 = "h2_shovel";
    last_kill_shovel_2 = "h2_karambit";

    gun_names = [
        ["h2_rpg", "none"],
        ["at4", "none"],
        ["h2_aa12", "fmj", "foregrip", "holo", "reflex", "silencershotgun", "xmag", "none"],
        ["h2_ak47", "reflex", "silencerar", "acog", "fmj", "holo", "thermal", "xmag", "foregrip", "none"],
        ["h2_ak74u", "acog", "fastfire", "fmj", "holo", "akimbo", "reflex", "thermal", "silencersmg", "xmag", "none"],
        ["h2_aug", "augscope", "fmj", "foregrip", "holo", "reflex", "silencerlmg", "thermal", "xmag", "none"],
        ["h2_barrett", "acog", "fmj", "thermal", "silencersniper", "xmag", "none"],
        ["h2_beretta393", "reflex", "silencerpistol", "fmj", "akimbo", "holo", "xmag", "none"],
        ["h2_cheytac", "acog", "fmj", "thermal", "silencersniper", "xmag", "none"],
        ["h2_colt45", "fmj", "silencerpistol", "akimbo", "tacknifecolt45", "xmag", "none"],
        ["h2_coltanaconda", "fmj", "akimbo", "tacknifecolt44", "none"],
        ["h2_deserteagle", "fmj", "akimbo", "tacknifedeagle", "none"],
        ["h2_fal", "reflex", "silencerar", "acog", "fmj", "holo", "thermal", "xmag", "foregrip", "none"],
        ["h2_famas", "reflex", "silencerar", "acog", "fmj", "holo", "thermal", "xmag", "foregrip", "none"],
        ["h2_fn2000", "f2000scope", "silencerar", "acog", "fmj", "holo", "thermal", "xmag", "foregrip", "none"],
        ["h2_glock", "reflex", "silencerpistol", "fmj", "akimbo", "holo", "xmag", "none"],
        ["h2_kriss", "acog", "akimbo", "fastfire", "fmj", "holo", "reflex", "silencersmg", "thermal", "xmag", "none"],
        ["h2_m1014", "fmj", "foregrip", "holo", "reflex", "silencershotgun", "xmag", "none"],
        ["h2_m16", "reflex", "silencerar", "acog", "fmj", "holo", "thermal", "xmag", "foregrip", "none"],
        ["h2_m21", "acog", "fmj", "thermal", "silencersniper", "xmag", "none"],
        ["h2_m240", "acog", "fmj", "foregrip", "holo", "reflex", "silencerlmg", "thermal", "xmag", "none"],
        ["h2_m40a3", "acog", "fmj", "silencersniper", "thermal", "none"],
        ["h2_m4", "reflex", "silencerar", "acog", "fmj", "holo", "thermal", "xmag", "foregrip", "none"],
        ["h2_m9", "fmj", "silencerpistol", "akimbo", "tacknifem9", "xmag", "none"],
        ["h2_masada", "reflex", "silencerar", "acog", "fmj", "holo", "thermal", "xmag", "foregrip", "none"],
        ["h2_mg4", "acog", "fmj", "foregrip", "holo", "reflex", "silencerlmg", "thermal", "xmag", "none"],
        ["h2_model1887", "fmj", "akimbo", "none"],
        ["h2_p90", "acog", "akimbo", "fastfire", "fmj", "holo", "reflex", "silencersmg", "thermal", "xmag", "none"],
        ["h2_pp2000", "reflex", "silencerpistol", "fmj", "holo", "xmag", "none"],
        ["h2_ranger", "fmj", "akimbo", "none"],
        ["h2_rpd", "acog", "fmj", "foregrip", "holo", "reflex", "silencerlmg", "thermal", "xmag", "none"],
        ["h2_sa80", "acog", "fmj", "foregrip", "holo", "reflex", "silencerlmg", "thermal", "xmag", "none"],
        ["h2_scar", "reflex", "silencerar", "acog", "fmj", "holo", "thermal", "xmag", "foregrip", "none"],
        ["h2_spas12", "fmj", "foregrip", "holo", "reflex", "silencershotgun", "xmag", "none"],
        ["h2_striker", "fmj", "foregrip", "holo", "reflex", "silencershotgun", "xmag", "none"],
        ["h2_tavor", "mars", "silencerar", "acog", "fmj", "holo", "thermal", "xmag", "foregrip", "none"],
        ["h2_tmp", "reflex", "silencerpistol", "fmj", "akimbo", "holo", "xmag", "none"],
        ["h2_ump45", "acog", "akimbo", "fastfire", "fmj", "holo", "reflex", "silencersmg", "thermal", "xmag", "none"],
        ["h2_usp", "fmj", "silencerpistol", "akimbo", "tacknifeusp", "xmag", "none"],
        ["h2_uzi", "acog", "akimbo", "fastfire", "fmj", "holo", "reflex", "silencersmg", "thermal", "xmag", "none"],
        ["h2_wa2000", "acog", "fmj", "thermal", "silencersniper", "xmag", "none"],
        ["h2_winchester1200", "fmj", "foregrip", "holo", "reflex", "silencershotgun", "acog", "thermal", "foregrip", "none"]
    ];

    gun_names = common_scripts\utility::array_randomize(gun_names);
    default_attachments = ["none"];

    for ( i = 0; i <= randomIntRange(23,27); i++ ) 
    {
        gunName = gun_names[i][0];
        attachmentCount = gun_names[i].size;
        random1 = randomIntRange(1,attachmentCount);
        random2 = randomIntRange(1,attachmentCount);
        gunAttachment1 = gun_names[i][random1];
        gunAttachment2 = gun_names[i][random2];
        guninfo(gunName, gunAttachment1, gunAttachment2);
    }

    rnd = randomInt(5);
    switch (rnd) 
    {
        case 1:
            guninfo("h2_shovel", "none", default_attachments);
            break;
        case 2:
            guninfo("h2_karambit", "none", default_attachments);
            break;
        case 3:
            guninfo("h2_sickle", "none", default_attachments);
            break;
        case 4:
            guninfo("h2_hatchet", "none", default_attachments);
            break;
        case 5:
            guninfo("h2_icepick", "none", default_attachments);
            break;
    }

}

isdedicatedmeleeweapon_stub( var_0 )
{
    if ( isSubStr(var_0, "h2_shovel_mp") || isSubStr(var_0, "h2_karambit_mp") || isSubStr(var_0, "h2_sickle_mp") || isSubStr(var_0, "h2_hatchet_mp") || isSubStr(var_0, "h2_icepick_mp") )
        return 1;

    return 0;
}

onPlayerConnect()
{
	while (true)
	{
		level waittill("connected", player);		

		player thread onPlayerSpawned();
	}
}

onPlayerSpawned()
{
	self endon("disconnect");
	
	while (true)
	{
		self waittill("spawned_player");
        //iPrintLn(maps\mp\gametypes\gun::getnextgun().fullname);
	}
}
/*
  Copyright (c) 2009-2017 Andreas Göransson <andreas.goransson@gmail.com>
  Copyright (c) 2009-2017 Indrek Ardel <indrek@ardel.eu>

  This file is part of Call of Duty 4 Promod.

  Call of Duty 4 Promod is licensed under Promod Modder Ethical Public License.
  Terms of license can be found in LICENSE.md document bundled with the project.
*/

giveLoadout( team, class )
{
	self takeAllWeapons();

	self setClientDvar( "loadout_curclass", class );
	self.curClass = class;

	primaryWeapon();
	self maps\mp\gametypes\_teams::playerModelForWeapon("m40a3");
	self setMoveSpeedScale( ( 1.0 - 0.05 * int( class == "assault" ) ) * !int( isDefined( level.strat_over ) && !level.strat_over ) );
}

sidearmWeapon()
{
}

primaryWeapon()
{
	class = self.pers["class"];
	self setPerk("specialty_fastreload");
	if(class == "m40")
	{
		self giveWeapon("remington700_mp", 0);
		self giveWeapon("m40a3_mp", 0);
		self setSpawnWeapon("m40a3_mp");
		self giveMaxAmmo("m40a3_mp");
		self giveMaxAmmo("remington700_mp");
	}
	else
	{
		self giveWeapon("remington700_mp", 0);
		self giveWeapon("m40a3_mp", 0);
		self setSpawnWeapon("remington700_mp");
		self giveMaxAmmo("m40a3_mp");
		self giveMaxAmmo("remington700_mp");
	}
}

preserveClass( class )
{
	CLASS_PRIMARY = "";
	CLASS_PRIMARY_ATTACHMENT = "";
	CLASS_SECONDARY = "";
	CLASS_SECONDARY_ATTACHMENT = "";
	CLASS_GRENADE = "";
	CLASS_CAMO = "";

	if ( class == "assault" )
	{
		CLASS_PRIMARY = "ASSAULT_PRIMARY";
		CLASS_PRIMARY_ATTACHMENT = "ASSAULT_PRIMARY_ATTACHMENT";
		CLASS_SECONDARY = "ASSAULT_SECONDARY";
		CLASS_SECONDARY_ATTACHMENT = "ASSAULT_SECONDARY_ATTACHMENT";
		CLASS_GRENADE = "ASSAULT_GRENADE";
		CLASS_CAMO = "ASSAULT_CAMO";
	}
	else if ( class == "specops" )
	{
		CLASS_PRIMARY = "SPECOPS_PRIMARY";
		CLASS_PRIMARY_ATTACHMENT = "SPECOPS_PRIMARY_ATTACHMENT";
		CLASS_SECONDARY = "SPECOPS_SECONDARY";
		CLASS_SECONDARY_ATTACHMENT = "SPECOPS_SECONDARY_ATTACHMENT";
		CLASS_GRENADE = "SPECOPS_GRENADE";
		CLASS_CAMO = "SPECOPS_CAMO";
	}
	else if ( class == "demolitions" )
	{
		CLASS_PRIMARY = "DEMOLITIONS_PRIMARY";
		CLASS_PRIMARY_ATTACHMENT = "DEMOLITIONS_PRIMARY_ATTACHMENT";
		CLASS_SECONDARY = "DEMOLITIONS_SECONDARY";
		CLASS_SECONDARY_ATTACHMENT = "DEMOLITIONS_SECONDARY_ATTACHMENT";
		CLASS_GRENADE = "DEMOLITIONS_GRENADE";
		CLASS_CAMO = "DEMOLITIONS_CAMO";
	}
	else if ( class == "sniper" )
	{
		CLASS_PRIMARY = "SNIPER_PRIMARY";
		CLASS_PRIMARY_ATTACHMENT = "SNIPER_PRIMARY_ATTACHMENT";
		CLASS_SECONDARY = "SNIPER_SECONDARY";
		CLASS_SECONDARY_ATTACHMENT = "SNIPER_SECONDARY_ATTACHMENT";
		CLASS_GRENADE = "SNIPER_GRENADE";
		CLASS_CAMO = "SNIPER_CAMO";
	}

	CLASS_PRIMARY_VALUE = int( tablelookup( "promod/customStatsTable.csv", 1, self.pers[class]["loadout_primary"], 0 ) );
	CLASS_PRIMARY_ATTACHMENT_VALUE = int( tablelookup( "promod/customStatsTable.csv", 1, self.pers[class]["loadout_primary_attachment"], 0 ) );
	CLASS_SECONDARY_VALUE = int( tablelookup( "promod/customStatsTable.csv", 1, self.pers[class]["loadout_secondary"], 0 ) );
	CLASS_SECONDARY_ATTACHMENT_VALUE = int( tablelookup( "promod/customStatsTable.csv", 1, self.pers[class]["loadout_secondary_attachment"], 0 ) );
	CLASS_GRENADE_VALUE = int( tablelookup( "promod/customStatsTable.csv", 1, self.pers[class]["loadout_grenade"], 0 ) );
	CLASS_CAMO_VALUE = int( tablelookup( "promod/customStatsTable.csv", 1, self.pers[class]["loadout_camo"], 0 ) );

	self set_config( CLASS_PRIMARY, CLASS_PRIMARY_VALUE );
	self set_config( CLASS_PRIMARY_ATTACHMENT, CLASS_PRIMARY_ATTACHMENT_VALUE );
	self set_config( CLASS_SECONDARY, CLASS_SECONDARY_VALUE );
	self set_config( CLASS_SECONDARY_ATTACHMENT, CLASS_SECONDARY_ATTACHMENT_VALUE );
	self set_config( CLASS_GRENADE, CLASS_GRENADE_VALUE );
	self set_config( CLASS_CAMO, CLASS_CAMO_VALUE );
}

set_config( dataName, value )
{
	self setStat( int( tableLookup( "promod/customStatsTable.csv", 1, dataName, 0 ) ), value );
}
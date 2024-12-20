printl( "Claucker's MODS v0.1c" );

for (local i = 1; i <= 4; i++)
{
    if (IncludeScript( "claucker_tps_mod_" + i ))
        printl( "Claucker's MOD [" + i + "] LOADED!" );
}
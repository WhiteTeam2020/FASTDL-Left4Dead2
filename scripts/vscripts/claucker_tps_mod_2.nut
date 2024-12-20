/************************************************************************************************
*
*	Claucker's Model Changer, claucker_tps_mod_2.nut
*
*    @author Claucker
*    @version 0.3c 17 March 2024
*
*		Allows to change survivors custom skins without replacing the orignal ones 
*		by using custom model (cmName) chat command. Where NAME is any name set up inside models_list.txt
*		
*	
************************************************************************************************/

// Original Survivors L4D1

MODEL_BILLNORMAL <- "models/survivors/survivor_namvet.mdl"
MODEL_ZOEYNORMAL <- "models/survivors/survivor_teenangst.mdl"
MODEL_LOUISNORMAL <- "models/survivors/survivor_manager.mdl"
MODEL_FRANCISNORMAL <- "models/survivors/survivor_biker.mdl"

// Original Survivors L4D2

MODEL_NICKNORMAL <- "models/survivors/survivor_gambler.mdl"
MODEL_ROCHELLENORMAL <- "models/survivors/survivor_producer.mdl"
MODEL_COACHNORMAL <- "models/survivors/survivor_coach.mdl"
MODEL_ELLISNORMAL <- "models/survivors/survivor_mechanic.mdl"

L4DMODELS <- 
[ 
	MODEL_BILLNORMAL, 
	MODEL_ZOEYNORMAL, 
	MODEL_LOUISNORMAL,
	MODEL_FRANCISNORMAL,
	MODEL_NICKNORMAL,
	MODEL_ROCHELLENORMAL,
	MODEL_COACHNORMAL,
	MODEL_ELLISNORMAL
];

C_MODELS <- [];
C_MNAMES <- [];

CUSTOM_MODELS_LIST <-
[
	"aya:models/custom_survivors/claucker_aya_onechanbara/survivor_teenangst.mdl",
	"claire:models/custom_survivors/claucker_claire_rerev2/survivor_teenangst.mdl",
	"kokoro:models/custom_survivors/claucker_kokoro_legend_doa/survivor_teenangst.mdl",
	"lady:models/custom_survivors/claucker_lady_dmc/survivor_teenangst.mdl",
	"marie:models/custom_survivors/marierosemod/marie_rose_mod.mdl",
	"mei:models/custom_survivors/claucker_mei_ow/survivor_teenangst.mdl",
	"misa:models/custom_survivors/claucker_misa_sagi/survivor_teenangst.mdl",
	"moira:models/custom_survivors/claucker_moira_rerev2/survivor_teenangst.mdl",
	"pajamei:models/custom_survivors/claucker_pajamei_ow/survivor_teenangst.mdl",
	"rona:models/custom_survivors/claucker_rona_metro/survivor_teenangst.mdl"
];

C_MNAMES_SERVER <- [];
C_MODELS_SERVER <- [];

//ANY_MODEL_FOUND <- false;
MODEL_INDEX <- 0;

/*
*
*
*			Game Events
*
*
*/

function OnGameEvent_player_spawn ( params )
{
	if (!("userid" in params)) 
		return;

	local player = GetPlayerFromUserID(params["userid"]);

	if (player == null || !player.IsValid() || IsPlayerABot(player) || !player.IsSurvivor()) 
		return;


	printl("Loading Claucker's Model Changer v0.3c ");

	load_files(player);

	register_server_models();
	join_custom_model_list();
	
	precache_all_models();
}

function OnGameEvent_player_say( params )
{

	local userID = params["userid"];
	local player = GetPlayerFromUserID( userID );
	local text = params["text"];

	set_default_models_by_command (player, text);
	set_custom_models_by_command (player, text);
	new_commands_to_add ( text );
}

/*
*
*
*			Utility
*
*
*/

function new_commands_to_add( command )
{
	switch ( command )
	{
		case "!cmname":
			show_model_name();
			break;
		
		case "!cmlist":
			show_names_and_paths();
			break;

		default:
	}
}

function show_names_and_paths()
{
	for (local i = 0; i < C_MODELS.len(); i++)
	{
		printl( C_MNAMES[i] );
	}

	printl("----------------------------------------");	
	
	for (local i = 0; i < C_MODELS.len(); i++)
	{
		printl( C_MODELS[i] );
	}

}

function show_model_name()
{
	if ( ( C_MNAMES[MODEL_INDEX] == "MODEL_NAME" || C_MNAMES[MODEL_INDEX] == "\r" ) || ( C_MNAMES[MODEL_INDEX] == "unexpected type null" ) || ( C_MNAMES[MODEL_INDEX] == "MODEL_NAME" ) || ( C_MNAMES[MODEL_INDEX] == "" ) || ( C_MNAMES[MODEL_INDEX] == null ) )
		MODEL_INDEX += 1;
	
	local name = C_MNAMES[MODEL_INDEX];
	Say( null, "Model found -> " + name + " type in !cm" + name + " to change", false );

	MODEL_INDEX += 1;
	MODEL_INDEX = ( MODEL_INDEX % ( C_MNAMES.len() ) );
}

function register_server_models()
{
	local str_helper = "";

	for (local i = 0; i < CUSTOM_MODELS_LIST.len(); i += 1)
	{
		str_helper = split( CUSTOM_MODELS_LIST[i], ":\r");

		//printl( str_helper + " | " + str_helper[0] + " | " + str_helper[1] );

		C_MNAMES_SERVER.append( str_helper[0] );
		C_MODELS_SERVER.append( str_helper[1] );

		//printl( "C[" + i + "]" + CUSTOM_MODELS_LIST[i] );
	}
}

function join_custom_model_list()
{
	local aux_names = [];
	local aux_models = [];
	local arr_size = C_MNAMES.len();

	for (local i = 0; i < C_MNAMES.len(); i += 1)
	{
		aux_names.append( C_MNAMES[i] );
		aux_models.append( C_MODELS[i] );
	}

	for (local i = 0; i < C_MNAMES_SERVER.len(); i += 1)
	{
		aux_names.append( C_MNAMES_SERVER[i] );
		aux_models.append( C_MODELS_SERVER[i] );
	}

	C_MNAMES = aux_names;
	C_MODELS = aux_models;

	for (local i = 0; i < C_MNAMES.len(); i++)
	{
		printl( C_MNAMES[i] + " " + C_MODELS[i] );
	}
}

function set_default_models_by_command( player, command )
{
	switch (command)
	{
		case "!cmbill":
			PrecacheModel(MODEL_BILLNORMAL);
			player.SetModel(MODEL_BILLNORMAL);
			break;
			
		case "!cmzoey":
			PrecacheModel(MODEL_ZOEYNORMAL);
			player.SetModel(MODEL_ZOEYNORMAL);
			break;
			
		case "!cmlouis":
			PrecacheModel(MODEL_LOUISNORMAL);
			player.SetModel(MODEL_LOUISNORMAL);
			break;
			
		case "!cmfrancis":
			PrecacheModel(MODEL_FRANCISNORMAL);
			player.SetModel(MODEL_FRANCISNORMAL);
			break;
			
		case "!cmnick":
			PrecacheModel(MODEL_NICKNORMAL);
			player.SetModel(MODEL_NICKNORMAL);
			break;
			
		case "!cmrochelle":
			PrecacheModel(MODEL_ROCHELLENORMAL);
			player.SetModel(MODEL_ROCHELLENORMAL);
			break;
			
		case "!cmcoach":
			PrecacheModel(MODEL_COACHNORMAL);
			player.SetModel(MODEL_COACHNORMAL);
			break;
			
		case "!cmellis":
			PrecacheModel(MODEL_ELLISNORMAL);
			player.SetModel(MODEL_ELLISNORMAL);
			break;

		case "!cmreload":
			load_files(player);
			break;

		default:
	}
}

function set_custom_models_by_command( player, command )
{
	local command_ = "";
	for (local i = 0; i < C_MODELS.len(); i++)
	{
		if (is_entry_valid(i))
		{
			command_ = "!cm" + C_MNAMES[i];
			if (command == command_)
			{
				PrecacheModel(C_MODELS[i]);
				player.SetModel(C_MODELS[i]);
				break;
			}
		}
	}
}

function precache_all_models()
{
	Convars.SetValue( "precache_all_survivors", "1" );

	// ForcePrecaching
	for (local i = 0; i < L4DMODELS.len(); i++)
	{
		PrecacheModel(L4DMODELS[i]);
	}
	
	for (local i = 0; i < C_MODELS.len(); i++)
	{
		if (!is_entry_valid(i))
			continue;

		PrecacheModel(C_MODELS[i]);
		printl( "Precached model (" + C_MNAMES[i] + ") [ " + C_MODELS[i] + " ]" );
	}
}

function is_entry_valid(index)
{
	return (
		C_MODELS[index] != "\r") && (C_MODELS[index] != "unexpected type null") && (C_MODELS[index] != "PLACE_CUSTOM_MODEL_PATH_HERE") && (C_MODELS[index] != "") && (C_MODELS[index] != null &&
		C_MNAMES[index] != "\r") && (C_MNAMES[index] != "unexpected type null") && (C_MNAMES[index] != "MODEL_NAME") && (C_MNAMES[index] != "") && (C_MNAMES[index] != null
	);
}

function register(player)
{
	local player_name = player.GetPlayerName();
	local player_folder = split(player.GetNetworkIDString(), ":");

	StringToFile( "custom_models/models_list.txt", "MODEL_NAME:PLACE_CUSTOM_MODEL_PATH_HERE\r" );
}

function load_files(player)
{
	local player_name = player.GetPlayerName();
	local player_folder = split(player.GetNetworkIDString(), ":");

	local fileStuff = "";

	local n_models = 0;

	printl("Searching for custom models... ");

	fileStuff = FileToString( "custom_models/models_list.txt" );

	get_info(fileStuff);

	for (local i = 0; i < C_MODELS.len(); i++)
	{
		if (is_entry_valid(i))
		{
			n_models++;
			printl( "Loaded model (" + C_MNAMES[i] + ") [ " + C_MODELS[i] + " ]" );
		}
	}

	if (n_models > 0)
	{
		Say( null, player_name + " has " + n_models + " custom models loaded!", false );
	}
	else
	{
		Say( null, "No custom models found for " + player_name + " inside models_list.txt file", false );
		Say( null, "You need to add the model name and path inside the models_list.txt file", false );

		register(player);
	}
}

function get_info(str_builder)
{
	local arr_name_path = [];
	
	local aux_names = [];
	local aux_models = [];

	local str_name_builder = "";
	local str_path_builder = "";
	
	arr_name_path = split(str_builder, ":\r");

	for (local i = 0; i < arr_name_path.len(); i += 2)
	{
		str_name_builder += arr_name_path[i] + "\n";
	}
	
	for (local i = 1; i < arr_name_path.len(); i += 2)
	{
		str_path_builder += arr_name_path[i] + "\n";
	}

	aux_names = split(str_name_builder, "\n");
	aux_models = split(str_path_builder, "\n");

	for (local i = 0; i < aux_names.len(); i += 1)
	{
		C_MNAMES.append( aux_names[i] );
		C_MODELS.append( aux_models[i] );
	}
}

__CollectEventCallbacks(this, "OnGameEvent_", "GameEventCallbacks", RegisterScriptGameEventListener);
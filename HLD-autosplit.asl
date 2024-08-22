state("HyperLightDrifter", "7/21/2017") {
	/* Steam current patch */
	uint room : 0x255B1F10;
	uint totalModules : 0x255A7DE4, 0x44, 0x0, 0x8;
	double isLoading : 0x255A7E24, 0x0, 0x0, 0x10, 0x0, 0xC, 0x28, 0x370;
}

state("HyperLightDrifter", "2/7/2019") {
	/* actual current patch */
	uint room : 0x255C60C0;
	double isLoading : 0x255BBFD4, 0x0, 0x0, 0x10, 0x0, 0xC, 0x28, 0x370;
}

state("HyperLightDrifter", "4/1/2016") {
	/* original patch */
	uint room : 0x2564C318;
}

startup {
	/*
	settings.Add("Warps", false);
	settings.Add("Modules", false);
	*/
	settings.Add("Alt Drifter", false);
	settings.SetToolTip("Alt Drifter", "Final split on entering the credits");

	vars.done = 0;
	vars.maxModules = 0;
}

init {

	if (modules.First().ModuleMemorySize == 631357440) {
		version = "7/21/2017";
	} else if (modules.First().ModuleMemorySize == 629932032) {
		version = "2/7/2019";
	} else if (modules.First().ModuleMemorySize == 631992320) {
		version = "4/1/2016";
	} else {
		/* unknown version */
		print("module size = " + modules.First().ModuleMemorySize.ToString());
	}
}

update {
	return true;
}

/*
start {
	if (current.newGame == 1 && old.newGame == 0) {
		return true;
	}
	return false;
}
*/

split {
	if (current.room != old.room) {

		/*
		if (current.room == 61 && old.room != 60 && old.room != 5) {
			if (settings["Warps"]) {
				return true;
			}
		}
		*/

		if (current.room == 8) {
			/* start of credits */
			if (settings["Alt Drifter"]) {
				return true;
			}
		}
	}

	/*
	if (current.totalModules == vars.maxModules + 1) {
		if (settings["Modules"]) {
			vars.maxModules++;
			return true;
		}
	}
	*/
}

isLoading {
	/*
	if (version != "7/21/2017" && version != "2/7/2019") {
		return false;
	}
	*/

	return (current.isLoading == 1);

}

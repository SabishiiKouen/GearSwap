
--[[
        Custom commands:
        Shorthand versions for each strategem type that uses the version appropriate for
        the current Arts.
                                        Light Arts              Dark Arts
        gs c scholar light              Light Arts/Addendum
        gs c scholar dark                                       Dark Arts/Addendum
        gs c scholar cost               Penury                  Parsimony
        gs c scholar speed              Celerity                Alacrity
        gs c scholar aoe                Accession               Manifestation
        gs c scholar power              Rapture                 Ebullience
        gs c scholar duration           Perpetuance
        gs c scholar accuracy           Altruism                Focalization
        gs c scholar enmity             Tranquility             Equanimity
        gs c scholar skillchain                                 Immanence
        gs c scholar addendum           Addendum: White         Addendum: Black
    
        Toggle Function: 
        gs c toggle melee               Toggle Melee mode on / off and locking of weapons
        gs c toggle mb                  Toggles Magic Burst Mode on / off.
        gs c toggle runspeed            Toggles locking on / off Herald's Gaiters
        gs c toggle idlemode            Toggles between Refresh and DT idle mode. Activating Sublimation JA will auto replace refresh set for sublimation set. DT set will superceed both.        
        gs c toggle regenmode           Toggles between Hybrid, Duration and Potency mode for regen set  
        gs c toggle nukemode            Toggles between Normal and Accuracy mode for midcast Nuking sets (MB included)  
        gs c toggle matchsc             Toggles auto swapping element to match the last SC that just happenned.
                
        Casting functions:
        these are to set fewer macros (1 cycle, 5 cast) to save macro space when playing lazily with controler
        
        gs c nuke cycle                 Cycles element type for nuking & SC
        gs c nuke cycledown             Cycles element type for nuking & SC in reverse order    
        gs c nuke t1                    Cast tier 1 nuke of saved element 
        gs c nuke t2                    Cast tier 2 nuke of saved element 
        gs c nuke t3                    Cast tier 3 nuke of saved element 
        gs c nuke t4                    Cast tier 4 nuke of saved element 
        gs c nuke t5                    Cast tier 5 nuke of saved element 
        gs c nuke helix                 Cast helix2 nuke of saved element 
        gs c nuke storm                 Cast Storm II buff of saved element  
                    
        gs c sc tier                    Cycles SC Tier (1 & 2)
        gs c sc castsc                  Cast All the stuff to create a SC burstable by the nuke element set with '/console gs c nuke element'.

        HUD Functions:
        gs c hud hide                   Toggles the Hud entirely on or off
        gs c hud hidemode               Toggles the Modes section of the HUD on or off
        gs c hud hidejob                Toggles the job section of the HUD on or off
        gs c hud hidebattle             Toggles the Battle section of the HUD on or off
        gs c hud lite                   Toggles the HUD in lightweight style for less screen estate usage. Also on ALT-END
        gs c hud keybinds               Toggles Display of the HUD keybindings (my defaults) You can change just under the binds in the Gearsets file.

        // OPTIONAL IF YOU WANT / NEED to skip the cycles...  
        gs c nuke Ice                   Set Element Type to Ice DO NOTE the Element needs a Capital letter. 
        gs c nuke Air                   Set Element Type to Air DO NOTE the Element needs a Capital letter. 
        gs c nuke Dark                  Set Element Type to Dark DO NOTE the Element needs a Capital letter. 
        gs c nuke Light                 Set Element Type to Light DO NOTE the Element needs a Capital letter. 
        gs c nuke Earth                 Set Element Type to Earth DO NOTE the Element needs a Capital letter. 
        gs c nuke Lightning             Set Element Type to Lightning DO NOTE the Element needs a Capital letter. 
        gs c nuke Water                 Set Element Type to Water DO NOTE the Element needs a Capital letter. 
        gs c nuke Fire                  Set Element Type to Fire DO NOTE the Element needs a Capital letter. 
--]]

-------------------------------------------------------------                                        
--                              
--      ,---.     |    o               
--      |   |,---.|--- .,---.,---.,---.
--      |   ||   ||    ||   ||   |`---.
--      `---'|---'`---'``---'`   '`---'
--           |                         
-------------------------------------------------------------  

include('organizer-lib') -- Can remove this if you dont use organizer
res = require('resources')
texts = require('texts')
include('Modes.lua')

-- Define your modes: 
-- You can add or remove modes in the table below, they will get picked up in the cycle automatically. 
-- to define sets for idle if you add more modes, name them: sets.me.idle.mymode and add 'mymode' in the group.
-- to define sets for regen if you add more modes, name them: sets.midcast.regen.mymode and add 'mymode' in the group.
-- Same idea for nuke modes. 
idleModes = M('refresh', 'dt', 'mdt')
regenModes = M('hybrid', 'duration', 'potency')
-- To add a new mode to nuking, you need to define both sets: sets.midcast.nuking.mynewmode as well as sets.midcast.MB.mynewmode
nukeModes = M('normal', 'acc')

-- Setting this to true will stop the text spam, and instead display modes in a UI.
-- Currently in construction.
use_UI = true
hud_x_pos = 1400    --important to update these if you have a smaller screen
hud_y_pos = 200     --important to update these if you have a smaller screen
hud_draggable = true
hud_font_size = 10
hud_transparency = 200 -- a value of 0 (invisible) to 255 (no transparency at all)
hud_font = 'Impact'
hud_keybinds = true

-- Setup your Key Bindings here:
    windower.send_command('bind insert gs c nuke cycle')        -- insert to Cycles Nuke element
    windower.send_command('bind delete gs c nuke cycledown')    -- delete to Cycles Nuke element in reverse order   
    windower.send_command('bind f9 gs c toggle idlemode')       -- F9 to change Idle Mode    
    windower.send_command('bind !f9 gs c toggle runspeed') 		-- Alt-F9 toggles locking on / off Herald's Gaiters
    windower.send_command('bind f12 gs c toggle melee')			-- F12 Toggle Melee mode on / off and locking of weapons
    windower.send_command('bind !` input /ma Stun <t>') 		-- Alt-` Quick Stun Shortcut.
    windower.send_command('bind home gs c sc tier')				-- home to change SC tier between Level 1 or Level 2 SC
    windower.send_command('bind end gs c toggle regenmode')		-- end to change Regen Mode	
    windower.send_command('bind f10 gs c toggle mb')            -- F10 toggles Magic Burst Mode on / off.
    windower.send_command('bind !f10 gs c toggle nukemode')		-- Alt-F10 to change Nuking Mode
    windower.send_command('bind ^F10 gs c toggle matchsc')      -- CTRL-F10 to change Match SC Mode      	
    windower.send_command('bind !end gs c hud lite')            -- Alt-End to toggle light hud version   

--[[
    This gets passed in when the Keybinds is turned on.
    Each one matches to a given variable within the text object
    IF you changed the Default Keybind above, Edit the ones below so it can be reflected in the hud using "//gs c hud keybinds" command
]]
keybinds_on = {}
keybinds_on['key_bind_idle'] = '(F9)'
keybinds_on['key_bind_regen'] = '(END)'
keybinds_on['key_bind_casting'] = '(ALT-F10)'
keybinds_on['key_bind_mburst'] = '(F10)'

keybinds_on['key_bind_element_cycle'] = '(INSERT)'
keybinds_on['key_bind_sc_level'] = '(HOME)'
keybinds_on['key_bind_lock_weapon'] = '(F12)'
keybinds_on['key_bind_movespeed_lock'] = '(ALT-F9)'
keybinds_on['key_bind_matchsc'] = '(CTRL-F10)'

-- Remember to unbind your keybinds on job change.
function user_unload()
    send_command('unbind insert')
    send_command('unbind delete')	
    send_command('unbind f9')
    send_command('unbind f10')
    send_command('unbind f12')
    send_command('unbind !`')
    send_command('unbind home')
    send_command('unbind end')
    send_command('unbind !f10')	
    send_command('unbind `f10')
    send_command('unbind !f9')	
    send_command('unbind !end')      	
end


--------------------------------------------------------------------------------------------------------------
include('SCH_Lib.lua')          -- leave this as is    
refreshType = idleModes[1]      -- leave this as is     
--------------------------------------------------------------------------------------------------------------


-- Optional. Swap to your sch macro sheet / book
set_macros(2,5) -- Sheet, Book


-------------------------------------------------------------                                        
--      ,---.                         |         
--      |  _.,---.,---.,---.,---.,---.|--- ,---.
--      |   ||---',---||    `---.|---'|    `---.
--      `---'`---'`---^`    `---'`---'`---'`---'
-------------------------------------------------------------                                              

-- Setup your Gear Sets below:
function get_sets()
  
    -- My formatting is very easy to follow. All sets that pertain to my character doing things are under 'me'.
    -- All sets that are equipped to faciliate my avatar's behaviour or abilities are under 'avatar', eg, Perpetuation, Blood Pacts, etc
      
    sets.me = {}        		-- leave this empty
    sets.buff = {} 				-- leave this empty
    sets.me.idle = {}			-- leave this empty

    -- Your idle set
    sets.me.idle.refresh = {main="Daybreak",
		sub="Ammurapi Shield",
		ammo="Homiliary",
		head="Befouled Crown",
		body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
		hands={ name="Merlinic Dastanas", augments={'Pet: Attack+6 Pet: Rng.Atk.+6','Attack+2','"Refresh"+1',}},
		legs="Assid. Pants +1",
		feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
		neck="Sanctity Necklace",
		waist="Fucho-no-Obi",
		left_ear="Infused Earring",
		right_ear="Loquac. Earring",
		left_ring="Sheltered Ring",
		right_ring="Karieyh Ring +1",
		back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},

    }

    -- Your idle Sublimation set combine from refresh or DT depening on mode.
    sets.me.idle.sublimation = set_combine(sets.me.idle.refresh,{head="Academic's Mortarboaard +2", body="Pedagogy Gown +3", waist="Embla Sash", ear1="Savant's Earring"})
    
    -- Your idle DT set
    sets.me.idle.dt = set_combine(sets.me.idle[refreshType],{head="Nyame Helm", body="Nyame Mail", hands="Nyame Gauntlets", legs="Nyame Flanchard", feet="Nyame Sollerets", ring1="Defending Ring"})
    sets.me.idle.mdt = set_combine(sets.me.idle[refreshType],{

    })  
	-- Your MP Recovered Whilst Resting Set
    sets.me.resting = { 

    }
    
    sets.me.latent_refresh = {waist="Fucho-no-obi"}     
    
	-- Combat Related Sets
    sets.me.melee = set_combine(sets.me.idle[idleModes.current],{

    })
      
    -- Weapon Skills sets just add them by name.
    sets.me["Shattersoul"] = {

    }
    sets.me["Myrkr"] = {

    }
      
    -- Feel free to add new weapon skills, make sure you spell it the same as in game. These are the only two I ever use though
  
    ------------
    -- Buff Sets
    ------------	
    -- Gear that needs to be worn to **actively** enhance a current player buff.
    -- Fill up following with your avaible pieces.
    sets.buff['Rapture'] = {head="Arbatel bonnet +1"}
    sets.buff['Perpetuance'] = {hands="Arbatel Bracers +1"}
    sets.buff['Immanence'] = {hands="Arbatel Bracers +1"}
    sets.buff['Penury'] = {legs="Arbatel Pants +1"}
    sets.buff['Parsimony'] = {legs="Arbatel Pants +1"}
    sets.buff['Celerity'] = {feet="Peda. Loafers +3"}
    sets.buff['Alacrity'] = {feet="Peda. Loafers +3"}
    sets.buff['Klimaform'] = {feet="Arbatel Loafers +1"}	
    -- Ebulience set empy now as we get better damage out of a good Merlinic head
    sets.buff['Ebullience'] = {} -- I left it there still if it becomes needed so the SCH.lua file won't need modification should you want to use this set
   
	
	
    ---------------
    -- Casting Sets
    ---------------
    sets.precast = {}   		-- Leave this empty  
    sets.midcast = {}    		-- Leave this empty  
    sets.aftercast = {}  		-- Leave this empty  
	sets.midcast.nuking = {}	-- leave this empty
	sets.midcast.MB	= {}		-- leave this empty      
    ----------
    -- Precast
    ----------
      
    -- Generic Casting Set that all others take off of. Here you should add all your fast cast 
    -- Grimoire: 10(cap:25) / rdm: 15
    sets.precast.casting = {ammo="Sapience Orb",
    head={ name="Amalric Coif", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}},
    body="Zendik Robe",
    hands="Agwu's Gages",
    legs="Assid. Pants +1",
    feet={ name="Merlinic Crackows", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','"Fast Cast"+6','CHR+9','Mag. Acc.+10','"Mag.Atk.Bns."+7',}},
    neck="Voltsurge Torque",
    waist="Embla Sash",
    left_ear="Malignance Earring",
    right_ear="Enchntr. Earring +1",
    left_ring="Kishar Ring",
    right_ring="Lebeche Ring",
    back={ name="Lugh's Cape", augments={'"Fast Cast"+10',}},

    }

	sets.precast["Stun"] = {

	}

    -- When spell school is aligned with grimoire, swap relevent pieces -- Can also use Arbatel +1 set here if you value 1% quickcast procs per piece. (2+ pieces)  
    -- Dont set_combine here, as this is the last step of the precast, it will have sorted all the needed pieces already based on type of spell.
    -- Then only swap in what under this set after everything else. 
    sets.precast.grimoire = {head="Peda. M.Board +3",

    }

	
    -- Enhancing Magic, eg. Siegal Sash, etc
    sets.precast.enhancing = set_combine(sets.precast.casting,{waist="Siegal Sash",


    })
  
    -- Stoneskin casting time -, works off of enhancing -
    sets.precast.stoneskin = set_combine(sets.precast.enhancing,{head="Umuthi Hat",

    })
      
    -- Curing Precast, Cure Spell Casting time -
    sets.precast.cure = set_combine(sets.precast.casting,{
	
    })
      
    ---------------------
    -- Ability Precasting
    ---------------------

    sets.precast["Tabula Rasa"] = {legs="Pedagogy Pants +3"}
    sets.precast["Enlightenment"] = {body="Peda. Gown +3"}	 
    sets.precast["Sublimation"] = {head="Acad. Mortar. +2", body="Peda. Gown +3"}	 

	
	----------
    -- Midcast
    ----------
	
    -- Just go make it, inventory will thank you and making rules for each is meh.
    sets.midcast.Obi = {
    	waist="Hachirin-no-Obi",
    }
	
	-----------------------------------------------------------------------------------------------
	-- Helix sets automatically derives from casting sets. SO DONT PUT ANYTHING IN THEM other than:
	-- Pixie in DarkHelix
	-- Boots that aren't arbatel +1 (15% of small numbers meh, amalric+1 does more)
	-- Belt that isn't Obi.
	-----------------------------------------------------------------------------------------------
    -- Make sure you have a non weather obi in this set. Helix get bonus naturally no need Obi.	
    
    sets.midcast.Helix = {main="Bunzi's Rod",
    sub="Ammurapi Shield",
    ammo="Pemphredo Tathlum",
    head="Agwu's Cap",
    body="Agwu's Robe",
    hands="Amalric Gages +1",
    legs="Agwu's Slops",
    feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
    neck={ name="Argute Stole +1", augments={'Path: A',}},
    waist="Eschan Stone",
    left_ear="Regal Earring",
    right_ear="Malignance Earring",
    left_ring="Freke Ring",
    right_ring="Mujin Band",
    back={ name="Bookworm's Cape", augments={'INT+1','Helix eff. dur. +19','"Regen" potency+9',}},

    }	
	sets.midcast.DarkHelix = set_combine(sets.midcast.Helix, {
		head="Pixie Hairpin +1",
		ring1="Archon Ring",
    })
	
	sets.midcast.LightHelix = set_combine(sets.midcast.Helix, {main="Daybreak"})
    -- Whatever you want to equip mid-cast as a catch all for all spells, and we'll overwrite later for individual spells
    sets.midcast.casting = {
    ammo="Pemphredo Tathlum",
    head="Agwu's Cap",
    body="Agwu's Robe",
    hands="Agwu's Gages",
    legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
    neck={ name="Argute Stole +1", augments={'Path: A',}},
    waist="Eschan Stone",
    left_ear="Regal Earring",
    right_ear="Malignance Earring",
    left_ring="Freke Ring",
    right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
    back={ name="Bookworm's Cape", augments={'INT+1','Helix eff. dur. +19','"Regen" potency+9',}},

    }
	
	sets.midcast["Sublimation"] = {head="Acad. Mortar. +2", body="Peda. Gown +3"}
    
    sets.midcast.nuking.normal = {main="Bunzi's Rod",
    sub="Ammurapi Shield",
    ammo="Pemphredo Tathlum",
    head={ name="Peda. M.Board +3", augments={'Enh. "Altruism" and "Focalization"',}},
    body={ name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    hands={ name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    legs={ name="Amalric Slops +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}},
    feet={ name="Amalric Nails +1", augments={'Mag. Acc.+20','"Mag.Atk.Bns."+20','"Conserve MP"+7',}},
    neck={ name="Argute Stole +1", augments={'Path: A',}},
    waist="Eschan Stone",
    left_ear="Regal Earring",
    right_ear="Malignance Earring",
    left_ring="Freke Ring",
    right_ring={ name="Metamor. Ring +1", augments={'Path: A',}},
    back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},

    }
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.normal = set_combine(sets.midcast.nuking.normal, {body="Agwu's Robe",ring2="Nujin Band",legs="Agwu's Slops",feet="Agwu's Pigaches",

    })
	
    sets.midcast.nuking.acc = {

    }
    -- used with toggle, default: F10
    -- Pieces to swap from freen nuke to Magic Burst
    sets.midcast.MB.acc = set_combine(sets.midcast.nuking.normal, {

    })	
	
    -- Enfeebling
	
    sets.midcast.IntEnfeebling = {main="Daybreak",
	sub="Ammurapi Shield",
    ammo="Pemphredo Tathlum",
    head="Acad. Mortar. +2",
    body={ name="Peda. Gown +3", augments={'Enhances "Enlightenment" effect',}},
    hands="Acad. Bracers +2",
    legs="Acad. Pants +3",
    feet="Acad. Loafers +2",
    neck={ name="Argute Stole +1", augments={'Path: A',}},
    waist={ name="Obstin. Sash", augments={'Path: A',}},
    left_ear="Regal Earring",
    right_ear="Malignance Earring",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},

    }
    sets.midcast.MndEnfeebling = set_combine(sets.midcast.IntEnfeebling, {head="",body="Cohort Cloak +1", })
	sets.midcast["Stun"] = sets.midcast.IntEnfeebling
    -- Enhancing
    sets.midcast.enhancing = set_combine(sets.midcast.casting,{main={ name="Musa", augments={'Path: C',}},
    ammo="Pemphredo Tathlum",
    head={ name="Telchine Cap", augments={'Mag. Evasion+24','Potency of "Cure" effect received+5%','Enh. Mag. eff. dur. +5',}},
    body={ name="Peda. Gown +3", augments={'Enhances "Enlightenment" effect',}},
    hands="Arbatel Bracers +1",
    legs={ name="Telchine Braconi", augments={'Mag. Acc.+6 "Mag.Atk.Bns."+6','Potency of "Cure" effect received+4%','Enh. Mag. eff. dur. +9',}},
    feet={ name="Telchine Pigaches", augments={'"Mag.Atk.Bns."+8','Potency of "Cure" effect received+5%','Enh. Mag. eff. dur. +7',}},
    neck="Incanter's Torque",
    waist="Embla Sash",
    left_ear="Andoaa Earring",
    right_ear="Malignance Earring",
    left_ring="Stikini Ring",
    right_ring="Stikini Ring",
    back="Perimede Cape",

    })
    sets.midcast.storm = set_combine(sets.midcast.enhancing,{

    })       
    sets.midcast.Protect =  sets.midcast.enhancing
    sets.midcast.Shell = sets.midcast.Protect
    -- Stoneskin
    sets.midcast.stoneskin = set_combine(sets.midcast.enhancing,{
		waist="Siegel Sash",
    })
    sets.midcast.refresh = set_combine(sets.midcast.enhancing,{
		head="Almaric Coif",feet="Inspirited Boots"
    })
    sets.midcast.aquaveil = sets.midcast.refresh
	
    sets.midcast["Drain"] = set_combine(sets.midcast.nuking, {main="Rubicundity",
		head="Pixie Hairpin +1",
		neck="Erra Pendant",
		ear1="Hirudinea Earring",
		ring1="Archon Ring",
		ring2="Evanescance Ring",
		waist="Fucho-no-Obi",
		legs="Peda. Pants +3",
		feet="Agwu's Pigaches",
    })
    sets.midcast["Aspir"] = sets.midcast["Drain"]
 	
 	sets.midcast.cure = {} -- Leave This Empty
    -- Cure Potency
    sets.midcast.cure.normal = set_combine(sets.midcast.casting,{main="Daybreak",
    sub="Ammurapi Shield",
    ammo="Staunch Tathlum +1",
    head={ name="Telchine Cap", augments={'Mag. Evasion+24','Potency of "Cure" effect received+5%','Enh. Mag. eff. dur. +5',}},
    body="Vrikodara Jupon",
    hands={ name="Telchine Gloves", augments={'Mag. Acc.+15','"Cure" potency +8%','"Regen" potency+3',}},
    legs="Acad. Pants +3",
    feet={ name="Telchine Pigaches", augments={'"Mag.Atk.Bns."+8','Potency of "Cure" effect received+5%','Enh. Mag. eff. dur. +7',}},
    neck="Phalaina Locket",
    waist="Gishdubar Sash",
    left_ear="Regal Earring",
    right_ear="Mendi. Earring",
    left_ring="Kunaji Ring",
    right_ring="Lebeche Ring",
    back="Solemnity Cape",

    })
    sets.midcast.cure.weather = set_combine(sets.midcast.cure.normal,{
		main="Chatoyant Staff",

    })    

    ------------
    -- Regen
    ------------	
	sets.midcast.regen = {} 	-- leave this empty
	-- Normal hybrid well rounded Regen
    sets.midcast.regen.hybrid = {main={ name="Musa", augments={'Path: C',}},
	ammo="Staunch Tathlum +1",
	head="Arbatel Bonnet +1",
	body={ name="Telchine Chas.", augments={'Mag. Acc.+9','"Cure" potency +7%','Enh. Mag. eff. dur. +5',}},
	hands={ name="Telchine Gloves", augments={'Mag. Acc.+15','"Cure" potency +8%','"Regen" potency+3',}},
	neck="Incanter's Torque",
    waist="Embla Sash",
    left_ear="Regal Earring",
    right_ear="Mendi. Earring",
    left_ring="Kunaji Ring",
    right_ring="Lebeche Ring",
    back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},
	legs={ name="Telchine Braconi", augments={'Mag. Acc.+6 "Mag.Atk.Bns."+6','Potency of "Cure" effect received+4%','Enh. Mag. eff. dur. +9',}},
    feet={ name="Telchine Pigaches", augments={'"Mag.Atk.Bns."+8','Potency of "Cure" effect received+5%','Enh. Mag. eff. dur. +7',}},
    }
	-- Focus on Regen Duration 	
    sets.midcast.regen.duration = set_combine(sets.midcast.regen.hybrid,{main={ name="Musa", augments={'Path: C',}},
    ammo="Staunch Tathlum +1",
    head={ name="Telchine Cap", augments={'Mag. Evasion+24','Potency of "Cure" effect received+5%','Enh. Mag. eff. dur. +5',}},body={ name="Telchine Chas.", augments={'"Regen"+1','"Regen" potency+3',}},
    body={ name="Telchine Chas.", augments={'Mag. Acc.+9','"Cure" potency +7%','Enh. Mag. eff. dur. +5',}},
    hands={ name="Telchine Gloves", augments={'Enh. Mag. eff. dur. +10',}},
    legs={ name="Telchine Braconi", augments={'Mag. Acc.+6 "Mag.Atk.Bns."+6','Potency of "Cure" effect received+4%','Enh. Mag. eff. dur. +9',}},
    feet={ name="Telchine Pigaches", augments={'"Mag.Atk.Bns."+8','Potency of "Cure" effect received+5%','Enh. Mag. eff. dur. +7',}},
    neck="Incanter's Torque",
    waist="Embla Sash",
    left_ear="Regal Earring",
    right_ear="Mendi. Earring",
    left_ring="Kunaji Ring",
    right_ring="Lebeche Ring",
    back={ name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','INT+10','"Mag.Atk.Bns."+10',}},

    }) 
	-- Focus on Regen Potency 	
    sets.midcast.regen.potency = set_combine(sets.midcast.regen.hybrid,{main={ name="Musa", augments={'Path: C',}},
    ammo="Staunch Tathlum +1",
	head="Arbatel Bonnet +1",
    
    body={ name="Telchine Chas.", augments={'"Regen"+1','"Regen" potency+3',}},
    hands={ name="Telchine Gloves", augments={'Mag. Acc.+15','"Cure" potency +8%','"Regen" potency+3',}},
    legs={ name="Telchine Braconi", augments={'Mag. Evasion+20','Pet: "Regen"+2','"Regen" potency+2',}},
    feet={ name="Telchine Pigaches", augments={'"Regen" potency+3',}},
    neck="Incanter's Torque",
    waist="Embla Sash",
    left_ear="Regal Earring",
    right_ear="Mendi. Earring",
    left_ring="Kunaji Ring",
    right_ring="Lebeche Ring",
    back="Bookworm's Cape",

    }) 
	
    ------------
    -- Aftercast
    ------------
      
    -- I don't use aftercast sets, as we handle what to equip later depending on conditions using a function.
	
end

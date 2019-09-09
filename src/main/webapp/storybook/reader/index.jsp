<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="en" itemscope itemtype="http://schema.org/WebPage"> <!--Change the lang property to your web"s language-->

<head prefix="og: http://ogp.me/ns#">

	<title></title> <!--Up to 60-70 Characters. Optimal Format: Primary Keyword - Secondary Keyword | Brand Name-->

	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no, maximum-scale=1">
	<meta name="description" content=""> <!--Page description. No longer than 155 characters.-->
	<meta name="keywords" content="">
	<meta name="author" content=""> <!--Name of the author.-->

	<!--Facebook Meta Tags-->
	<meta property="og:image" content="http://" /> <!--URL of Image to show-->
	<meta property="og:description" content="" /> <!--Page Description-->
	<meta property="og:site_name" content="" /> <!--The Name Here-->
	<meta property="og:url" content="http://" /> <!--The Web main URL-->
	<meta property="og:title" content="" /> <!--The Title Here-->

	<!--Google Meta Tags-->
	<meta itemprop="name" content=""> <!--The Name or Title Here-->
	<meta itemprop="description" content=""> <!--Page Description-->
	<meta itemprop="image" content="http://"> <!--URL of Image to show-->

	<!--Twitter Meta Tags - You"ll have to validate your website here: https://dev.twitter.com/docs/cards/validation/validator-->
	<meta name="twitter:card" content="summary_large_image"> <!--Content Card Type-->
	<meta name="twitter:domain" content=""> <!--Your web"s domain-->
	<meta name="twitter:site" content="@"> <!--@publisher-->
	<meta name="twitter:title" content=""> <!--Page Title-->
	<meta name="twitter:description" content=""> <!--Page description less than 200 characters-->
	<meta name="twitter:creator" content="@"> <!--@author-->
	<meta name="twitter:image:src" content="http://"> <!--URL of Image to show-->

	<!--Android Meta Tags-->
	<meta name="mobile-web-app-capable" content="yes">
	<link rel="icon" sizes="192x192" href="img/icons/icon_192x192.png"> <!--192 x 192 Icon-->
	<link rel="icon" sizes="128x128" href="img/icons/icon_128x128.png"> <!--128 x 128 Icon-->

	<!--Apple Meta Tags-->
	<meta name="apple-mobile-web-app-title" content=""> <!--App Title or Name-->
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent"> <!--Styling for the iOS Status Bar-->
	<link rel="apple-touch-icon" href="img/icons/icon_60x60.png"> <!--60 x 60 Icon-->
	<link rel="apple-touch-icon" sizes="76x76" href="img/icons/icon_76x76.png"> <!--76 x 76 Icon-->
	<link rel="apple-touch-icon" sizes="120x120" href="img/icons/icon_120x120.png"> <!--120 x 120 Icon-->
	<link rel="apple-touch-icon" sizes="152x152" href="img/icons/icon_152x152.png"> <!--152 x 152 Icon-->
	<link rel="apple-touch-icon" sizes="152x152" href="img/icons/icon_167x167.png"> <!--167 x 167 Icon-->
	<link rel="apple-touch-icon" sizes="152x152" href="img/icons/icon_180x180.png"> <!--180 x 180 Icon-->

	<!--Microsoft Tags-->
	<meta name="msapplication-TileColor" content=""> <!--Color of the tile on Windows. In hexadecimal format-->
	<meta name="application-name" content="" /> <!-- App Title -->
	<meta name="msapplication-tooltip" content="" /> <!--Small text on hover-->
	<meta name="msapplication-starturl" content="http://" /> <!-- URL to start in -->
	<meta name="msapplication-square70x70logo" content="img/icons/icon_70x70.png" /> <!--Image for Tile 70x70-->
	<meta name="msapplication-square150x150logo" content="img/icons/icon_150x150.png" /> <!--Image for Tile 150x150-->
	<meta name="msapplication-wide310x150logo" content="img/icons/icon_310x150.png" /> <!--Image for Tile 310x150-->
	<meta name="msapplication-square310x310logo" content="img/icons/icon_310x310.png" /> <!--Image for Tile 310x310-->

	<link rel="publisher" href=""> <!--Publisher"s Google+ URL-->

	<meta name="theme-color" content=""><!--Theme color for browsers in hexadecimal format.-->

	<link rel="shortcut icon" href="img/favicon.ico" /> <!--Favicon. Good tool for creating one: http://xiconeditor.com/ Create all sizes.-->
	<link rel="canonical" href=""> <!--Canonical URL of your webpage-->

	<link rel="manifest" href="manifest.json">

	<link rel="stylesheet" href="style/animate.min.css">
	<link rel="stylesheet" href="style/csshake.min.css">
	<link rel="stylesheet" href="style/font-awesome.min.css">
	<link rel="stylesheet" href="style/kayros.min.css">
	<link rel="stylesheet" href="style/monogatari.css">
	<link rel="stylesheet" href="style/main.css">

	<script src="js/polyfill.min.js"></script>
	<script src="js/jquery.min.js"></script>
	<script src="js/particles.min.js"></script>
	<script src="js/typed.min.js"></script>
	<script src="js/artemis.min.js"></script>
	<script src="js/strings.js"></script>
	<script src="js/options.js"></script>
	<script src="js/storage.js"></script>
	<script src="js/script.js.jsp"></script>
	<script src="js/monogatari.js"></script>
	<script src="js/main.js"></script>

</head>

<body>

	<!-- Fallback when JavaScript is not available -->
	<noscript>
		<div class="middle align-center">
			<h2>JavaScript Disabled or not Supported.</h2>
			<small>To play this game, please enable JavaScript executing or use a different browser.</small>
		</div>
	</noscript>

	<!-- Notice messages -->
	<div data-notice="exit" class="modal">
		<div class="row spaced">
			<p data-string="Confirm" class="col xs12 m12 l12 xl12">Do you want to quit</p>
			<div class="col xs12 m12 l12 xl12">
				<button data-action="quit" data-string="Quit">Quit</button>
				<button data-action="dismiss-notice" data-string="Cancel">Cancel</button>
			</div>
		</div>
	</div>

	<div data-notice="slot-deletion" class="modal">
		<div class="row spaced">
			<p data-string="SlotDeletion" class="col xs12 m12 l12 xl12">Are you sure you want to delete this slot?</p>
			<p class="col xs12 m12 l12 xl12"><small></small></p>
			<div class="col xs12 m12 l12 xl12">
				<button data-action="delete-slot" data-string="Delete">Delete</button>
				<button data-action="dismiss-notice" data-string="Cancel">Cancel</button>
			</div>
		</div>
	</div>

	<div data-notice="slot-overwrite" class="modal">
		<div class="row spaced">
			<p data-string="SlotOverwrite" class="col xs12 m12 l12 xl12">Are you sure you want to overwrite this slot?</p>
			<input type="text" name="name" class="margin-1 col xs12 m12 l12 xl12" required>
			<div class="col xs12 m12 l12 xl12">
				<button data-action="overwrite-slot" data-string="Delete">Overwrite</button>
				<button data-action="dismiss-notice" data-string="Cancel">Cancel</button>
			</div>
		</div>
	</div>

	<!--Game Screen -->
	<section id="game" class="unselectable">
		<div id="particles-js" data-ui="particles"></div>
		<div id="background" data-ui="background"></div>
		<div>
			<audio type="audio/mpeg" data-component="music"></audio>
			<audio type="audio/mpeg" data-component="voice"></audio>
			<audio type="audio/mpeg" data-component="sound"></audio>
			<div class="video-wrapper align-center vertical middle" data-component="video" data-ui="video-player">
				<video type="video/mp4" data-ui="player" controls="true"></video>
				<button data-action="close-video" data-string="Close">Close</button>
			</div>

			<div data-component="modal" data-ui="messages" class="middle">
				<div data-ui="message-content"></div>
				<div class="horizontal align-center" data-ui="inner-menu">
					<button data-action="close" data-close="messages" data-string="Close">Close</button>
				</div>
			</div>
			<div data-component="modal" data-ui="input" class="middle">
				<p data-ui="input-message" class="block"></p>
				<input type="text">
				<small data-ui="warning" class="block"></small>
				<div>
					<button data-action="submit">Ok</button>
				</div>
			</div>
		</div>

		<div data-ui="choices" class="vertical align-center middle"></div>
		<div data-ui="text">
			<img data-ui="face" alt="">
			<span data-ui="who"></span>
			<p data-ui="say"></p>
		</div>
		<div data-ui="quick-menu" class="align-right">
			<span data-action="back"><span class="fa fa-arrow-left"></span> <span data-string="Back">Back</span></span>
			<span data-action="distraction-free"><span class="fa fa-eye" data-action="distraction-free"></span> <span data-string="Hide" data-action="distraction-free">Hide</span></span>
			<span data-action="auto-play"><span class="fa fa-play-circle" data-action="auto-play"></span> <span data-string="AutoPlay" data-action="auto-play">Auto</span></span>
			<span data-action="open-menu" data-open="save"><span class="fa fa-save" data-action="open-menu" data-open="save"></span> <span data-string="Save" data-action="open-menu" data-open="save">Save</span></span>
			<span data-action="open-menu" data-open="load"><span class="fa fa-undo" data-action="open-menu" data-open="load"></span> <span data-string="Load" data-action="open-menu" data-open="load">Load</span></span>
			<span data-action="open-menu" data-open="settings"><span class="fa fa-gear" data-action="open-menu" data-open="settings"></span> <span data-string="Settings" data-action="open-menu" data-open="settings">Settings</span></span>
			<span data-action="end"><span class="fa fa-times-circle-o" data-action="end"></span> <span data-string="Quit" data-action="end">Quit</span></span>
		</div>
	</section>

	<!-- Loading Screen -->
	<section data-menu="loading" data-background="">
		<div class="middle">
			<h2 data-string="Loading">Loading</h2>
			<progress data-ui="load-progress" value="0" max="100"></progress>
			<small data-string="LoadingMessage">Wait while the assets are loaded.</small>
		</div>
	</section>

	<!-- Main Screen -->
	<section data-menu="main" data-background="">
		<audio type="audio/mpeg" data-component="ambient"></audio>

		<div class="vertical align-right bottom animated bounceIn" data-ui="inner-menu">
			<button data-action="start" data-string="Start">Start</button>
			<button data-action="open-menu" data-open="load" data-string="Load">Load</button>
			<button data-action="open-menu" data-open="settings" data-string="Settings">Settings</button>
			<button data-action="open-menu" data-open="help" data-string="Help">Help</button>
		</div>
	</section>

	<!-- Save Screen -->
	<section data-menu="save" data-background="">
		<button class="fa fa-arrow-left top left" data-action="back"></button>
		<div class="horizontal">
			<input type="text" placeholder="Save Slot Name" data-input="slotName" required>
			<button data-string="Save" data-action="save">Save</button>
		</div>
		<div data-ui="slots" class="row spaced align-center"></div>
	</section>

	<!-- Load Screen -->
	<section data-menu="load" data-background="">
		<button class="fa fa-arrow-left top left" data-action="back"></button>
		<h2 data-string="Load">Load</h2>
		<div data-ui="saveSlots">
			<h3 data-string="LoadSlots">Saved Games</h3>
			<div data-ui="slots" class="row spaced align-center"></div>
		</div>
		<div data-ui="autoSaveSlots">
			<h3 data-string="LoadAutoSaveSlots">Auto Saved Games</h3>
			<div data-ui="slots" class="row spaced align-center"></div>
		</div>
	</section>

	<!-- Settings Screen -->
	<section data-menu="settings" data-background="" class="align-center">
		<button class="fa fa-arrow-left top left" data-action="back"></button>
		<h2 data-string="Settings">Settings</h2>
		<div class="row spaced padded-1 align-center">
			<div class="col xs12 s12 m6 l6 xl6 r6">
				<div data-settings="audio" class="vertical align-center">
					<h3 data-string="Audio">Audio</h3>
					<span data-string="Music">Music Volume:</span>
					<input type="range" min="0.0" max="1.0" step="0.1" data-action="set-volume" data-target="music">
					<span data-string="Sound">Sound Volume:</span>
					<input type="range" min="0.0" max="1.0" step="0.1" data-action="set-volume" data-target="sound">
					<span data-string="Voice">Voice Volume:</span>
					<input type="range" min="0.0" max="1.0" step="0.1" data-action="set-volume" data-target="voice">
				</div>
			</div>

			<div class="col xs12 s12 m6 l6 xl6 r6">

				<div data-settings="text-speed">
					<h3 data-string="TextSpeed">Text Speed</h3>
					<input type="range" min="1" max="50" step="1" data-action="set-text-speed">
				</div>

				<div data-settings="auto-play-speed">
					<h3 data-string="AutoPlaySpeed">Auto Play Speed</h3>
					<input type="range" min="0" max="60" step="1" data-action="set-auto-play-speed">
				</div>
				<div data-settings="language">
					<h3 data-string="Language">Language</h3>
					<div class="horizontal">
						<select data-action="set-language">
								<option value="English">English</option>
								<option value="EspaÃ±ol">EspaÃ±ol</option>
								<option value="FranÃ§ais">FranÃ§ais</option>
								<option value="æ¥æ¬èª">æ¥æ¬èª</option>
								<option value="Nederlands">Nederlands</option>
							</select>
						<span class="fa fa-unsorted" data-select="set-language"></span>
					</div>

				</div>

				<div data-settings="resolution" data-platform="electron">
					<h3 data-string="Resolution">Resolution</h3>
					<div class="horizontal">
						<select data-action="set-resolution"></select>
						<span class="fa fa-unsorted" data-select="set-resolution"></span>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!--Help Screen -->
	<section data-menu="help" data-background="">
		<button class="fa fa-arrow-left top left" data-action="back"></button>
		<h2 data-string="Help">Help</h2>
		<div class="align-left padded-1">
			<p data-string="AdvanceHelp">To advance through the game, click anywhere on the game screen or press the space key.</p>
			<h3 data-string="QuickButtons">Quick Menu Buttons</h3>
			<p><span class="fa fa-arrow-left"></span> <span data-string="BackButton">Back.</span></p>
			<p><span class="fa fa-eye"></span> <span data-string="HideButton">Hide Text.</span></p>
			<p><span class="fa fa-save"></span> <span data-string="SaveButon">Open the Save Screen.</span></p>
			<p><span class="fa fa-undo"></span> <span data-string="LoadButton">Open the Load Screen.</span></p>
			<p><span class="fa fa-gear"></span> <span data-string="SettingsButton">Open the Settings Screen.</span></p>
			<p><span class="fa fa-times-circle-o"></span> <span data-string="QuitButton">Quit Game.</span></p>
		</div>
	</section>

</body>

</html>
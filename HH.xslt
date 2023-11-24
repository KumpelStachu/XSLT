<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
	>
	<xsl:output method="html" indent="yes"/>
	
	<xsl:template match="/">
		
		<html>
			<head>
				<meta charset="UTF-8" />
				<title>Hypertext hypermedia</title>
				<meta name="viewport" content="width=device-width, initial-scale=1.0" />
				<link rel="stylesheet" href="index.css" />
			</head>
			<body>
				<div id="wrapper">
					<header>
						<h1>Hypertext hypermedia</h1>
					</header>
					
					<!-- menu do poruszania w obrębie strony -->
					<!-- menu for moving within a page -->
					<xsl:call-template name="menu"/>
					
					
					<div id="content">
						<h2 id="scientists">Scientists</h2>
						<!-- a place for information about hypertext scientists -->
						<xsl:apply-templates select="hypertext/people"/>
						
						<h2 id="systems">Systems</h2>
						<!-- a place for information about hypertext systems -->
						<xsl:apply-templates select="hypertext/systemList"/>
						
					</div>
					<!-- end content -->
				</div>
				<!-- end wrapper -->
				<footer>
					<xsl:apply-templates select="hypertext/author"/>	<!-- wywołanie szablonu pozwalającego na wyświetlenie informacji o imieniu oraz nazwisku studenta -->
				</footer>
			</body>
		</html>
		
	</xsl:template>
	
	<xsl:template match="author">
		Copyright 2022, <xsl:value-of select="name"/>&#160;<xsl:value-of select="surname"/>
	</xsl:template>
	
	<xsl:template name="menu">
		<nav>
			<ul>
				<li> <a href="#scientists">Scientists</a> </li>
				<li> <a href="#systems">Systems</a> 	</li>
			</ul>
		</nav>		
	</xsl:template>
	
	<xsl:template match="system">
		<div>
			<h3>
				<xsl:value-of select="name"/>
			</h3>
			<p>
				<xsl:value-of select="description"/>
			</p>
			<ul>
				<xsl:apply-templates select="link"/>
			</ul>
		</div>
	</xsl:template>
	
	<xsl:template match="link">
		<xsl:if test="not(position() = last())">
			<li>	
				<a>
					<xsl:attribute name="href" select="@source"/>
					<xsl:value-of select="."/>
				</a>
			</li>
		</xsl:if>
	</xsl:template>
	
	<xsl:template match="person">
		<div>
			<h3>
				<xsl:value-of select="name"/>&#160;<xsl:value-of select="surname"/>
			</h3>
			<xsl:apply-templates select="image"/>
			<div>
				Date of birth: <xsl:value-of select="birth"/>
				<xsl:if test="@alive='no'">
					<br/>
					Date of death: <xsl:value-of select="death"/>
				</xsl:if>
			</div>
			<p>
				<xsl:value-of select="about"/>
			</p>
			<h4>Achievements</h4>
			<xsl:for-each select="achievementList//achievement">
				<xsl:sort select="title"/>
				<div>
					<xsl:number value="position()" format="0) "/>
					<xsl:value-of select="title"/>
				</div>
				<div>
					<xsl:value-of select="description"/>	
				</div>
			</xsl:for-each>
			<ul>
				<xsl:apply-templates select="link"/>
			</ul>
		</div>
	</xsl:template>
	
	<xsl:template match="image">
		<img class="right">
			<xsl:attribute name="src" select="@source"/>
			<xsl:attribute name="title" select="."/>
			<xsl:attribute name="alt" select="."/>
		</img>
	</xsl:template>
	
</xsl:stylesheet>

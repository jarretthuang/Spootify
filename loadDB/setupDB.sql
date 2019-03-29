SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS Artist1, Artist2, Playlist, SpootifyUser, BillingInfo, Subscriber, Guest, Track, 
Analytics, Album1, Album2, CreatesTrack, StoresAlbum, FollowsPlaylist, StoresTrack, TrackInPlaylist;

SET FOREIGN_KEY_CHECKS=1;

CREATE TABLE Artist1(
    imageURL CHAR(100) PRIMARY KEY,
    genre CHAR(30));
 
CREATE TABLE Artist2(
artistId INT PRIMARY KEY,
name CHAR(30),
imageURL CHAR(100),
FOREIGN KEY (imageURL) REFERENCES Artist1(imageURL));
 
CREATE TABLE Playlist(
playlistId INT PRIMARY KEY,
isPublic CHAR(1),
description CHAR(100));
 
CREATE TABLE SpootifyUser (
userId INT PRIMARY KEY,
name CHAR(30),
imageURL CHAR(100));
 
CREATE TABLE BillingInfo(
    cardNumber CHAR(40) PRIMARY KEY,
    monthlyRate REAL);
 
CREATE TABLE Subscriber(
    userId INT PRIMARY KEY,
    subscriptionType CHAR(30),
    cardNumber CHAR(40) UNIQUE,
FOREIGN KEY(userId) REFERENCES SpootifyUser(userId),
FOREIGN KEY(cardNumber) REFERENCES BillingInfo(cardNumber));
 
CREATE TABLE Guest(
    userId INT PRIMARY KEY,
    balance REAL,
FOREIGN KEY(userId) REFERENCES SpootifyUser(userId));

CREATE TABLE Track(
    trackId INT PRIMARY KEY,
    analyticsId INT UNIQUE NOT NULL,
    albumId INT,
    name CHAR(30),
    duration INT,
    popularity INT);
 
CREATE TABLE Analytics(
    trackId INT,
    analyticsId INT,
    liveliness FLOAT,
    speechiness FLOAT,
    danceability FLOAT,
    instrumentalness FLOAT,
    energy FLOAT,
    analyticsKey INT,
    loudness FLOAT,
    tempo FLOAT,
    PRIMARY KEY(trackId, analyticsId),
    FOREIGN KEY(trackId) REFERENCES Track(trackId) ON DELETE CASCADE);
 
ALTER TABLE Track
    ADD FOREIGN KEY (trackId, analyticsId) REFERENCES Analytics(trackId, analyticsId);
 
CREATE TABLE Album1(
    imageURL CHAR(100) PRIMARY KEY,
    label CHAR(40),
    genre CHAR(30));
 
CREATE TABLE Album2(
    albumId INT PRIMARY KEY,
    imageURL CHAR(100),
FOREIGN KEY(imageURL) REFERENCES Album1(imageURL));
 
ALTER TABLE Track
    ADD FOREIGN KEY (albumId) REFERENCES Album2(albumId);
 
CREATE TABLE CreatesTrack(
    artistId INT,
    trackId INT,
    PRIMARY KEY(artistId, trackId),
    FOREIGN KEY(artistId) REFERENCES Artist2(artistId),
    FOREIGN KEY(trackId) REFERENCES Track(trackId));
 
CREATE TABLE StoresAlbum(
    userId INT,
    albumId INT,
    PRIMARY KEY(userId, albumId),
    FOREIGN KEY(userId) REFERENCES SpootifyUser(userId),
    FOREIGN KEY(albumId) REFERENCES Album2(albumId));
 
CREATE TABLE FollowsPlaylist(
playlistId INT,
    userId INT,
    PRIMARY KEY(playlistId, userId),
    FOREIGN KEY(userId) REFERENCES SpootifyUser(userId),
    FOREIGN KEY(playlistId) REFERENCES Playlist(playlistId));
 
CREATE TABLE StoresTrack(
userId INT,
trackId INT,
PRIMARY KEY(userId, trackId),
FOREIGN KEY(userId) REFERENCES SpootifyUser(userId),
FOREIGN KEY(trackId) REFERENCES Track(trackId));
 
CREATE TABLE TrackInPlaylist (
    trackId INT,
    playlistId INT,
    PRIMARY KEY (trackId, playlistId),
    FOREIGN KEY (trackId) REFERENCES Track(trackId),
    FOREIGN KEY (playlistId) REFERENCES Playlist(playlistId) ON DELETE CASCADE);
 
ALTER TABLE spootify.FollowsPlaylist
   ADD CONSTRAINT Follows_Playlist_Cascade
   FOREIGN KEY (playlistId) REFERENCES Playlist(playlistId) ON DELETE CASCADE;

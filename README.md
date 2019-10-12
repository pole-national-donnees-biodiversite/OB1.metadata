# Défi OB1  

_Elie Arnaud, Yvan Le Bras, Oussama Chaib, Juliette Silhol, Laura Leroi, Clément Grandidier, Dorian Cazau_  

Git de l'équipe OB1 de l'Ocean Hackathon 2019 - Brest.  

## Description du défi

De plus en plus de données scientifiques sont aujourd'hui accessibles en accès ouvert. Cette mise à disposition est un premier pas essentiel vers un meilleur partage des connaissances et une réutilisation massives des données. Malheureusement, le partage du "matériel brut" ne suffit pas, et aujourd'hui plus que jamais se pose la question de la structuration de ces données. Comment faire en sorte que les données soient suffisamment bien décrites pour pouvoir être compréhensibles et réutilisées le plus largement possible ? Dans le cadre du projet "Pôle national de données de biodiversité", des actions en cours propose l'utilisation d'un standard de metadonnees, l'EML (Ecological Metadata Language), comme standard pivot d'outils et services qui faciliteraient cette structuration des données écologique et leur réutilisation. Des questionnements particuliers ont émergé concernant les données marines et ocean hackathon représente une initiative parfaite pour avancer sur certains aspects et laisser de potentiels hackers proposer d'améliorer ou/et créer des produits d'intérêt.  

**Objectifs**

En termes d'outils, nous travaillons sur le développement d'une application interactive R Shiny nommée [MetaSHARK](https://github.com/earnaud/MetaShARK). Nous aimerions développer des “modules” en R ou autre langage permettant d’automatiser les traitements de données marines hétérogènes pour par exemple parcourir des données d'écologie (séquences d'ADN ou données de présence d'espèces) et environnementales (données satellitaires ou autres données décrivant les conditions physico-chimiques du milieu) pour remplir de manière automatique et/ou assistée les champs de métadonnées pouvant l’être (étendues taxonomique, géographique et temporelle de l’étude ...).  

## Pistes envisagées
- Blockchain & Peer to Peer. Pour distribuer
  - A1 les données et/ou métadonnées (MTD)
  - A2 logiciels notamment ceux développés en B1 et B2
- Deux modules R Shiny
  - B1 "Inférence" automatique de MTD, notamment basé sur utilisation d'expression régulière (RegEx)
  - B2 "Sémantique" sur attributs (aussi nommés variables) : faire un lien entre les attributs et des ressoruces terminologiques exitantes notamment ontologies du domaine
- Récupérer des données hétérogènes proposées au Océan hackathon + extérieures avec leurs MTD et proposer 
  - C1 d'y ajouter des MTD -> structuration / qualification des MTD
  - C2 Faire remonter aux entrepôts des données d'origine les améliorations de MTD
- "Mapping" manuel de standards entre
  - D1 ISO19139 / EML / Darwin-Core / Tethys
  - Tethys
- Business Model
  - Indicateurs / métriques autour de la "complétude" des données en MTD
  - Indicateurs / métriques autour des données stockées inutilement car non rétuilisable notamment car MTD pas assez détaillées

### Gestion métadonnées
- datapackage https://github.com/frictionlessdata/datapackage-r notamment fonction dataPackage$infer 
```
datapackage=datapackage.r::infer("OBSMAM1.csv",getwd())
```
ne semble que fonctionner avec des fichiers .csv 
créer une liste composée de sous-listes décrivant les métadonnées du fichier : path, profile, encoding, name, format, mediatype et schema. Dans la sous-liste "schema" sont distingués les "fields" du dataset (nom des headers), auxquels sont attribués un "name",un "type" et "format", et les missing values.

- metadatar https://github.com/annakrystalli/metadatar 
- taxonomyCleanr (A workflow and set of functions to clean your taxonomy data using R) https://github.com/EDIorg/taxonomyCleanr 
- dataspice https://github.com/ropenscilabs/dataspice dont déjà des choses côté EML : https://github.com/ropenscilabs/dataspice/blob/master/R/eml_to_spice.R
- dataCleanR (A collection of user friendly data cleaning functions - EDIorg/dataCleanr) https://github.com/EDIorg/dataCleanr/blob/master/README.md
dataCleanr convertie l'encodage des données date et heure en standard ISO8601
```
Contaminants2 =read.table("Contaminants2.csv", header=TRUE, quote="", sep =";")
dateContaminants2 = Contaminants2$Passage...Date #extration des données "date"
dataContaminants2_cvn= iso8601_convert(dateContaminants2, orders = 'mdy') 
```
ici orders='mdy' car les données "date" sont de format jj/mm/aa 
mettre orders='mdy HM' si l'heure est rensignée en plus. 
  - time format management: iso8601_convert converts date and time strings to standard ISO 8601 formatted strings, https://ediorg.github.io/dataCleanr/articles/iso8601_functions.html
- taxize " The EML R package can leverage existing functions in the R package taxize to automatically generate the rank classification metadata" / rOpenSci | taxize tutorial / taxa - taxonomic classes for R
  - https://ropensci.org/tutorials/taxize_tutorial/
- ritis - Integrated Taxonomic Information Service (ITIS) R client
  - https://github.com/ropensci/ritis
- binomen - taxonomic name classes and parsing methods
  - https://github.com/ropensci/binomen

- https://github.com/ropensci/phylocomr
  - ecovolve/ph_ecovolve - interface to ecovolve executable, and a higher level interface
  - phylomatic/ph_phylomatic - interface to phylomatic executable, and a higher level interface
  - phylocom - interface to phylocom executable
  - ph_aot - higher level interface to aot
  - ph_bladj - higher level interface to bladj
  - ph_comdist/ph_comdistnt - higher level interface to comdist
  - ph_comstruct - higher level interface to comstruct
  - ph_comtrait - higher level interface to comtrait
  - ph_pd - higher level interface to Faith's phylogenetic diversity

- Données accoustiques
  - https://cran.r-project.org/web/packages/bioacoustics/bioacoustics.pdf
```
# Tests via package R bioacoustics on PNMR AFB Data
install.packages("bioacoustics")
library("bioacoustics")
blob_detection("PNMR_AFB_1786.wav", metadata = TRUE)
threshold_detection("PNMR_AFB_1786.wav", metadata = TRUE)
```
Output:
```
$`data`
$`data`$`event_data`
           filename starting_time  duration freq_max_amp freq_max freq_min bandwidth freq_start
1 PNMR_AFB_1786.wav  00:00:05.646 29.296875     16089.47 16144.78 16063.40  81.38438   16144.78
2 PNMR_AFB_1786.wav  00:00:06.228 27.343750     16096.15 16137.02 16051.26  85.76752   16083.10
3 PNMR_AFB_1786.wav  00:00:14.728 29.296875     16089.90 16136.83 16050.77  86.06028   16091.88
4 PNMR_AFB_1786.wav  00:00:15.312 26.367188     16094.48 16098.43 16045.26  53.17348   16088.76
5 PNMR_AFB_1786.wav  00:00:21.455  5.859375     16096.57 16184.78 16070.83 113.94552   16182.17
6 PNMR_AFB_1786.wav  00:00:23.470 14.648438     16213.01 16213.01 16099.13 113.87569   16101.32
7 PNMR_AFB_1786.wav  00:00:24.010 28.320312     16083.23 16144.83 16045.00  99.82951   16144.83
8 PNMR_AFB_1786.wav  00:00:24.591 26.367188     16083.35 16097.04 16045.17  51.87780   16092.08
  freq_center freq_end freq_knee       fc freq_bw_knee_fc bin_max_amp pc_freq_max_amp pc_freq_max
1    16073.17 16131.99  16131.99 16072.54       59.443992    16133.52        60.00000    0.000000
2    16072.35 16114.30  16137.02 16091.39       45.632574    16127.97        25.00000   92.857143
3    16090.86 16050.77  16136.83 16080.15       56.680645    16136.18        60.00000    3.333333
4    16088.03 16098.43  16045.26 16093.20      -47.940899    16122.11        55.55556   96.296296
5    16096.57 16144.09  16144.09 16070.83       73.254364    16225.01        50.00000   16.666667
6    16185.08 16196.88  16165.41 16204.47      -39.060591    16337.88        80.00000   80.000000
7    16083.23 16045.00  16089.70 16083.24        6.459109    16135.29        48.27586    0.000000
8    16066.02 16049.63  16049.63 16086.02      -36.389296    16119.45        81.48148   14.814815
  pc_freq_min   pc_knee temp_bw_knee_fc     slope kalman_slope curve_neg curve_pos_start
1    83.33333 96.666667       6.8359375  2.777920   0.81743127 166.99199       -96.36751
2    60.71429 92.857143       1.9531250  3.136641  -0.04311283 170.07980       -11.72001
3    96.66667  3.333333     -25.3906250  2.937524   1.42447332 138.09866       -93.12434
4    77.77778 77.777778       3.9062500  2.016653  -0.15005653 123.92154       -50.71399
5    66.66667 83.333333       0.9765625 19.446702  14.43692359  77.06258         0.00000
6    13.33333 33.333333      -7.8125000  7.773913  -8.67769885 109.52032       -63.07620
7    96.55172  3.448276     -20.5078125  3.525014   0.84390627 160.78292       -94.88639
8    55.55556 96.296296       0.9765625  1.967514   0.84317583 144.93926       -17.38110
  curve_pos_end mid_offset      snr        hd smoothness
1     -70.62448  11.803140 16.40073 -6.345830   267.8748
2    -158.35979   4.478406 13.93181 -5.684036   490.7512
3     -44.97432   3.559369 16.36572 -5.952053   341.5568
4     -73.20755  -7.003559 13.20965 -5.808741   339.9623
5     -77.06258  12.788415 12.39127 -3.891112   195.6713
6     -46.44412 -20.203057 11.45287 -1.140431   244.6858
7     -65.89653   2.335721 16.41052 -5.885345   327.2530
8    -127.55816  11.836430 13.86977 -6.697608   362.6874

$`data`$amp_track
$`data`$amp_track[[1]]
 [1] -39.34336 -41.01218 -42.31877 -40.04641 -37.53132 -38.44804 -34.71749 -34.42614 -33.53178
[10] -33.68775 -32.61804 -31.26009 -30.69791 -30.78077 -30.59193 -30.87812 -31.17210 -30.09240
[19] -29.80574 -29.98648 -30.32677 -30.32046 -31.31542 -31.25304 -32.09930 -32.65068 -33.32163
[28] -33.93300 -36.88490 -40.69755

$`data`$amp_track[[2]]
 [1] -38.45636 -37.96882 -35.92512 -35.80912 -33.69464 -33.26974 -33.27729 -32.55743 -32.87222
[10] -33.19629 -33.81976 -33.28068 -33.41800 -32.93820 -34.09956 -34.01273 -33.36717 -34.60436
[19] -34.96376 -35.20493 -35.07480 -34.08019 -34.04585 -33.31913 -34.33819 -36.80080 -40.80484
[28] -38.50128

$`data`$amp_track[[3]]
 [1] -48.70213 -47.69709 -43.03022 -41.04507 -37.33530 -35.34662 -37.56567 -37.88586 -35.87849
[10] -33.44572 -32.52065 -32.15973 -31.22080 -31.76343 -32.11893 -30.96082 -30.08622 -29.90786
[19] -29.24583 -29.39483 -30.35151 -31.35575 -32.04116 -32.25454 -32.46633 -32.61129 -32.70930
[28] -33.24032 -34.45465 -37.17492

$`data`$amp_track[[4]]
 [1] -39.71391 -38.58722 -39.65428 -38.33266 -36.39017 -35.97160 -35.06299 -33.79648 -33.67274
[10] -33.50497 -32.67786 -32.33768 -32.30892 -32.02514 -32.17148 -31.38822 -31.94320 -32.30385
[19] -33.02872 -34.32353 -34.57888 -36.71774 -36.40520 -36.28098 -35.25941 -38.39054 -41.39286

$`data`$amp_track[[5]]
[1] -54.93426 -43.55197 -40.72185 -40.71314 -41.67942 -43.41321

$`data`$amp_track[[6]]
 [1] -39.49499 -37.27416 -35.44234 -35.17835 -33.99279 -34.52252 -35.03783 -34.40224 -36.97103
[10] -38.97789 -35.17561 -33.81736 -33.26393 -35.25095 -39.85005

$`data`$amp_track[[7]]
 [1] -40.26873 -42.99576 -43.36498 -38.81641 -37.43041 -38.01701 -34.86826 -34.15572 -32.65020
[10] -33.65120 -33.26210 -31.77745 -30.79341 -30.13587 -29.81730 -30.37129 -31.17099 -30.60829
[19] -30.67852 -30.67691 -30.69601 -30.23675 -30.89546 -30.71945 -31.29235 -31.64909 -32.45223
[28] -33.34910 -38.04469

$`data`$amp_track[[8]]
 [1] -40.16612 -38.55242 -36.14557 -35.59251 -35.65671 -34.01114 -34.18763 -34.35032 -33.56238
[10] -34.11149 -34.51272 -35.24674 -34.29319 -34.45614 -34.07960 -34.91646 -34.44175 -33.63692
[19] -34.46173 -33.95574 -33.80327 -33.26432 -33.10474 -33.17612 -33.79079 -35.27017 -37.89384


$`data`$freq_track
$`data`$freq_track[[1]]
 [1] 16144.78 16119.46 16101.50 16077.16 16080.78 16085.74 16093.73 16085.20 16073.56 16078.01
[11] 16091.62 16094.34 16088.52 16078.95 16076.46 16073.17 16079.68 16091.80 16089.47 16088.42
[21] 16086.23 16082.45 16072.54 16075.42 16069.27 16063.40 16063.90 16072.31 16071.85 16131.99

$`data`$freq_track[[2]]
 [1] 16083.10 16077.61 16081.01 16094.58 16095.58 16090.13 16094.43 16096.15 16088.97 16091.70
[11] 16087.92 16092.97 16084.47 16089.14 16072.35 16082.18 16080.78 16051.26 16058.68 16052.98
[21] 16065.53 16072.25 16088.06 16091.07 16091.39 16071.65 16137.02 16114.30

$`data`$freq_track[[3]]
 [1] 16091.88 16136.83 16115.15 16109.68 16106.31 16101.83 16088.21 16066.63 16084.54 16116.23
[11] 16098.01 16090.66 16085.33 16085.65 16077.96 16090.86 16092.26 16088.24 16089.90 16081.67
[21] 16068.60 16067.45 16071.62 16072.44 16076.77 16081.18 16082.34 16080.15 16072.97 16050.77

$`data`$freq_track[[4]]
 [1] 16088.76 16082.32 16070.69 16077.41 16060.93 16069.48 16074.40 16074.80 16081.17 16083.61
[11] 16091.11 16086.25 16086.80 16088.03 16093.15 16094.48 16085.72 16093.20 16091.76 16085.47
[21] 16086.48 16045.26 16062.93 16071.64 16086.52 16077.02 16098.43

$`data`$freq_track[[5]]
[1] 16182.17 16184.78 16156.48 16096.57 16070.83 16144.09

$`data`$freq_track[[6]]
 [1] 16101.32 16118.40 16099.13 16099.46 16124.02 16165.41 16156.90 16185.08 16196.07 16201.33
[11] 16200.44 16211.28 16213.01 16204.47 16196.88

$`data`$freq_track[[7]]
 [1] 16144.83 16089.70 16072.96 16075.43 16076.98 16112.56 16105.94 16092.31 16078.48 16075.80
[11] 16086.78 16095.02 16092.92 16090.19 16083.23 16067.74 16065.87 16084.36 16084.20 16088.37
[21] 16089.42 16089.09 16083.24 16085.88 16081.63 16080.21 16079.44 16083.76 16045.00

$`data`$freq_track[[8]]
 [1] 16092.08 16091.83 16091.96 16086.13 16097.04 16095.75 16086.18 16089.53 16091.57 16079.39
[11] 16080.38 16064.84 16078.25 16066.02 16069.78 16045.17 16059.80 16055.65 16053.35 16066.80
[21] 16073.00 16084.06 16083.35 16094.76 16089.74 16086.02 16049.63


$`data`$event_start
[1] 185025 204097 482625 501761 703041 769089 786785 805825

$`data`$event_end
[1] 185984 204992 483584 502624 703232 769568 787712 806688


$metadata
$metadata$`file`
$metadata$`file`$`sample_rate`
[1] 32768

$metadata$`file`$bit_depth
[1] 16



attr(,"class")
[1] "threshold_detection"
```
- Données images
```
install.packages("exiftoolr")
install_exiftool()
library("exiftoolr")
files <- list.files(pattern = "*.JPG")
dat <- exif_read(files)
exif_read(files)
```
Output
```
          SourceFile ExifToolVersion           FileName Directory FileSize
1 PNMR_AFB_10450.JPG            11.7 PNMR_AFB_10450.JPG         .  2343731
             FileModifyDate            FileAccessDate            FileCreateDate FilePermissions
1 2019:10:12 17:11:13+02:00 2019:10:12 17:25:40+02:00 2019:10:12 17:25:40+02:00             666
  FileType FileTypeExtension   MIMEType ExifByteOrder             ImageDescription Make     Model
1     JPEG               JPG image/jpeg            MM Transport maritime en Iroise SONY DSLR-A100
  Orientation XResolution YResolution ResolutionUnit        Software          ModifyDate
1           1          72          72              2 DSLR-A100 v1.04 2013:09:14 12:06:14
            Artist YCbCrPositioning                                             Copyright
1 Sandrine Quintin                1 Sandrine Quintin / Agence des aires marines protegees
  ExposureTime FNumber ExposureProgram ISO ExifVersion    DateTimeOriginal          CreateDate
1       0.0025       8               2 100        0221 2013:09:14 00:00:00 2013:09:14 00:00:00
  ComponentsConfiguration CompressedBitsPerPixel BrightnessValue ExposureCompensation
1                 1 2 3 0                      8            9.75                    0
  MaxApertureValue MeteringMode LightSource Flash FocalLength       SubjectArea FileFormat
1         5.598343            5          10    24         120 1936 1296 329 393    0 0 0 2
  SonyModelID CreativeStyle DynamicRangeOptimizer MakerNoteVersion AFSensorActive
1         256          None                     1             MLT0              4
  AFStatusActiveSensor AFStatusTop-right AFStatusBottom-right AFStatusBottom
1                   31            -32768                   94         -32768
  AFStatusMiddleHorizontal AFStatusCenterVertical AFStatusTop AFStatusTop-left AFStatusBottom-left
1                      186                     31      -32768           -32768                 -65
  FocusLocked AFPoint AFMode AFStatusLeft AFStatusCenterHorizontal AFStatusRight AFAreaMode
1          64       0      3       -32768                      180           186          0
  DriveMode Rotation ImageStabilizationSetting DynamicRangeOptimizerMode ExposureCompensationMode
1         5        0                         1                         1                        0
  WBBracketShotNumber WhiteBalanceBracketing ExposureBracketShotNumber FlashFunction AverageLV
1                   0                      0                         0             0     9.875
  FrameNumber WB_RGBLevels   WB_GBRGLevels        WB_RedLevelsTungsten
1           0  512 256 366 256 366 512 256 249 257 264 271 281 288 298
            WB_BlueLevelsTungsten        WB_RedLevelsDaylight       WB_BlueLevelsDaylight
1 1152 1104 1056 1004 970 928 890 406 419 431 443 457 470 485 534 512 490 471 447 428 410
           WB_RedLevelsCloudy         WB_BlueLevelsCloudy           WB_RedLevelsFlash
1 428 442 454 471 482 496 512 475 454 435 415 399 382 366 433 447 459 473 488 501 518
           WB_BlueLevelsFlash     WB_RedLevelsFluorescent     WB_BlueLevelsFluorescent
1 512 490 470 446 431 412 395 272 291 437 488 451 568 506 1141 906 783 589 509 497 449
            WB_RedLevelsShade          WB_BlueLevelsShade WB_RedLevel6500K WB_BlueLevel6500K
1 482 498 512 525 544 558 576 470 450 431 411 393 376 360              490               421
  WB_RedLevelCustom WB_BlueLevelCustom WB_RedLevel3500K WB_BlueLevel3500K
1               443                471              334               744
                                                                                                                                                                                                                                                                                           WB_RedLevelsKelvin
1 241 252 263 273 282 292 301 309 318 327 334 343 350 358 364 372 378 384 391 397 401 408 412 419 424 428 433 438 442 447 452 454 462 464 470 472 475 480 482 488 490 493 496 498 501 506 509 512 514 518 520 520 524 528 528 532 534 538 540 540 544 546 546 550 552 556 556 558 558 562 564 564 568 568 570
                                                                                                                                                                                                                                                                                              WB_BlueLevelsKelvin
1 1216 1140 1068 1012 960 914 876 834 802 772 744 720 694 674 654 640 622 606 592 576 564 552 544 532 524 514 506 496 490 482 475 470 462 457 450 445 440 435 431 426 421 419 412 410 406 401 399 395 393 388 384 384 380 378 376 372 370 368 364 362 360 358 356 354 352 350 349 347 347 343 341 339 339 337 336
  WB_RBLevelsFlash WB_RBLevelsCoolWhiteF WB_RBLevelsTungsten WB_RBLevelsDaylight WB_RBLevelsCloudy
1          473 446               437 783            271 1004             443 471           471 415
  WB_RBLevelsShade WB_RBLevels6500K WB_RBLevelsCustom WB_RBLevels3500K
1          525 411          490 421           443 471          334 744
                                                                                                                                                                                                 AEMeteringSegments
1 9.875 10 9.875 10.125 10.125 10.125 10 10.25 10 10 10 10 10 10.125 10.125 10.125 10.25 10 10 10.125 10.25 10 10.125 10.125 10.125 9.875 9.875 9.875 9.5 9.875 9.875 9.875 10 9.625 9.625 9.5 9.5 9.375 9.25 9.875
  MeasuredLV                                                           TiffMeteringImage
1       9.75 base64:SUkqAAgAAAAOAP4ABAABAAAAAAAAAAABBAABAAAAKAAAAAEBBAABA[..9819 more..]
  FocusDistance MaxAperture InternalSerialNumber CompressedImageSize PreviewImageStart
1      3.668016    5.656854         702101705900             2284557             27788
  PreviewImageLength SceneMode MinoltaQuality FlashExposureComp Teleconverter RawAndJpgRecording
1              26252        16              2                 0             0                  0
  ZoneMatching ColorTemperature LensType ColorCompensationFilter WhiteBalanceFineTune
1            0                0       24                       0                    3
  ImageStabilization ExposureCompensationSetting HighSpeedSync ShutterSpeedSetting ApertureSetting
1                  1                           0             0          0.00390625        5.656854
  DriveMode2 FocusMode AFPointSelected FlashMode FlashExposureCompSet ISOSetting ZoneMatchingMode
1          5         4               1         0                    0          0                0
  FlashMetering PrioritySetupShutterRelease SelfTimerTime ContinuousBracketing
1             0                           0             0                  771
  SingleFrameBracketing WhiteBalanceSetting PresetWhiteBalance ColorTemperatureSetting
1                   770               32769                  2                       0
  CustomWBSetting DynamicRangeOptimizerSetting FreeMemoryCardImages CustomWBRedLevel
1               0                            1                   99                0
  CustomWBGreenLevel CustomWBBlueLevel CustomWBError SonyImageSize SonyQuality InstantPlaybackTime
1                  0                 0             0             0          32                   2
  InstantPlaybackSetup NoiseReduction EyeStartAF RedEyeReduction FlashDefault AutoBracketOrder
1                    1              1          0               0            0                0
  FocusHoldButton AELButton ControlDialSet AFAssist CardShutterLock LensShutterLock
1               0         0              0        0               1               0
  AFAreaIllumination MonitorDisplayOff RecordDisplay PlayDisplay ExposureIndicator
1                  0                 0             0           0               128
  AELExposureIndicator ExposureBracketingIndicatorLast MeteringOffScaleIndicator
1                    0                               0                         0
  FlashExposureIndicator FlashExposureIndicatorNext FlashExposureIndicatorLast FocusModeSwitch
1                      0                          0                          0               0
  FlashType AELock BatteryState WhiteBalance ColorMode UserComment FlashpixVersion ColorSpace
1         0      0            6           32         0                        0100          1
  ExifImageWidth ExifImageHeight InteropIndex InteropVersion FileSource SceneType CustomRendered
1           3872            2592          R98           0100          3         1              0
  ExposureMode DigitalZoomRatio FocalLengthIn35mmFormat SceneCaptureType GainControl Contrast
1            0                0                     180                0           0        0
  Saturation Sharpness                   XPTitle         XPAuthor
1          0         0 Trafic maritime en Iroise Sandrine Quintin
                                                 XPKeywords                    XPSubject
1 Parc naturel marin d'Iroise, Mer d'Iroise, Agent public,  Transport maritime en Iroise
  PrintIMVersion Compression ThumbnailOffset ThumbnailLength                CurrentIPTCDigest
1           0300           6           25770            2017 0c1465a8a0430b4558f80bbd36992292
                                                                           Keywords DateCreated
1 Trafic maritime,Bateau, Parc naturel marin d'Iroise, Mer d'Iroise, Agent public,   2013:09:14
  DigitalCreationDate          By-line                                                Credit
1          2013:09:14 Sandrine Quintin Sandrine Quintin / Agence des aires marines protegees
            Source    Writer-Editor ApplicationRecordVersion           XMPToolkit
1 Sandrine Quintin Sandrine Quintin                        4 Image::ExifTool 9.08
         LastKeywordIPTC         LastKeywordXMP                      Caption          Creator
1 Trafic maritime,Bateau Trafic maritime,Bateau Transport maritime en Iroise Sandrine Quintin
                   Description                                                Rights
1 Transport maritime en Iroise Sandrine Quintin / Agence des aires marines protegees
                 Subject                     Title           Author    CaptionWriter ImageWidth
1 Trafic maritime,Bateau Trafic maritime en Iroise Sandrine Quintin Sandrine Quintin       3872
  ImageHeight EncodingProcess BitsPerSample ColorComponents YCbCrSubSampling Aperture BlueBalance
1        2592               0             8               3              2 1        8    1.429688
  ImageSize LensID Megapixels
1 3872 2592     24   10.03622
                                                                  PreviewImage RedBalance
1 base64:/9j/2wCEAAgFBgcGBQgHBgcJCAgJDBQNDAsLDBgREg4UHRkeHhwZH[..34951 more..]          2
  ScaleFactor35efl ShutterSpeed
1              1.5       0.0025
                                                               ThumbnailImage CircleOfConfusion
1 base64:/9j/2wDFABAKChAYKDI8DAwOEho6PDYODBAYKDhEOA4QFhwyVlA+/[..2639 more..]        0.02003084
                                DOF                                FOV FocalLength35efl
1 3.52869214310477 3.81879436425615 11.0498994677646 0.709603234563736              180
  HyperfocalDistance LightValue
1           89.86143   14.64386
> exif_read("PNMR_AFB_10450.JPG")
          SourceFile ExifToolVersion           FileName Directory FileSize
1 PNMR_AFB_10450.JPG            11.7 PNMR_AFB_10450.JPG         .  2343731
             FileModifyDate            FileAccessDate            FileCreateDate FilePermissions
1 2019:10:12 17:11:13+02:00 2019:10:12 17:25:40+02:00 2019:10:12 17:25:40+02:00             666
  FileType FileTypeExtension   MIMEType ExifByteOrder             ImageDescription Make     Model
1     JPEG               JPG image/jpeg            MM Transport maritime en Iroise SONY DSLR-A100
  Orientation XResolution YResolution ResolutionUnit        Software          ModifyDate
1           1          72          72              2 DSLR-A100 v1.04 2013:09:14 12:06:14
            Artist YCbCrPositioning                                             Copyright
1 Sandrine Quintin                1 Sandrine Quintin / Agence des aires marines protegees
  ExposureTime FNumber ExposureProgram ISO ExifVersion    DateTimeOriginal          CreateDate
1       0.0025       8               2 100        0221 2013:09:14 00:00:00 2013:09:14 00:00:00
  ComponentsConfiguration CompressedBitsPerPixel BrightnessValue ExposureCompensation
1                 1 2 3 0                      8            9.75                    0
  MaxApertureValue MeteringMode LightSource Flash FocalLength       SubjectArea FileFormat
1         5.598343            5          10    24         120 1936 1296 329 393    0 0 0 2
  SonyModelID CreativeStyle DynamicRangeOptimizer MakerNoteVersion AFSensorActive
1         256          None                     1             MLT0              4
  AFStatusActiveSensor AFStatusTop-right AFStatusBottom-right AFStatusBottom
1                   31            -32768                   94         -32768
  AFStatusMiddleHorizontal AFStatusCenterVertical AFStatusTop AFStatusTop-left AFStatusBottom-left
1                      186                     31      -32768           -32768                 -65
  FocusLocked AFPoint AFMode AFStatusLeft AFStatusCenterHorizontal AFStatusRight AFAreaMode
1          64       0      3       -32768                      180           186          0
  DriveMode Rotation ImageStabilizationSetting DynamicRangeOptimizerMode ExposureCompensationMode
1         5        0                         1                         1                        0
  WBBracketShotNumber WhiteBalanceBracketing ExposureBracketShotNumber FlashFunction AverageLV
1                   0                      0                         0             0     9.875
  FrameNumber WB_RGBLevels   WB_GBRGLevels        WB_RedLevelsTungsten
1           0  512 256 366 256 366 512 256 249 257 264 271 281 288 298
            WB_BlueLevelsTungsten        WB_RedLevelsDaylight       WB_BlueLevelsDaylight
1 1152 1104 1056 1004 970 928 890 406 419 431 443 457 470 485 534 512 490 471 447 428 410
           WB_RedLevelsCloudy         WB_BlueLevelsCloudy           WB_RedLevelsFlash
1 428 442 454 471 482 496 512 475 454 435 415 399 382 366 433 447 459 473 488 501 518
           WB_BlueLevelsFlash     WB_RedLevelsFluorescent     WB_BlueLevelsFluorescent
1 512 490 470 446 431 412 395 272 291 437 488 451 568 506 1141 906 783 589 509 497 449
            WB_RedLevelsShade          WB_BlueLevelsShade WB_RedLevel6500K WB_BlueLevel6500K
1 482 498 512 525 544 558 576 470 450 431 411 393 376 360              490               421
  WB_RedLevelCustom WB_BlueLevelCustom WB_RedLevel3500K WB_BlueLevel3500K
1               443                471              334               744
                                                                                                                                                                                                                                                                                           WB_RedLevelsKelvin
1 241 252 263 273 282 292 301 309 318 327 334 343 350 358 364 372 378 384 391 397 401 408 412 419 424 428 433 438 442 447 452 454 462 464 470 472 475 480 482 488 490 493 496 498 501 506 509 512 514 518 520 520 524 528 528 532 534 538 540 540 544 546 546 550 552 556 556 558 558 562 564 564 568 568 570
                                                                                                                                                                                                                                                                                              WB_BlueLevelsKelvin
1 1216 1140 1068 1012 960 914 876 834 802 772 744 720 694 674 654 640 622 606 592 576 564 552 544 532 524 514 506 496 490 482 475 470 462 457 450 445 440 435 431 426 421 419 412 410 406 401 399 395 393 388 384 384 380 378 376 372 370 368 364 362 360 358 356 354 352 350 349 347 347 343 341 339 339 337 336
  WB_RBLevelsFlash WB_RBLevelsCoolWhiteF WB_RBLevelsTungsten WB_RBLevelsDaylight WB_RBLevelsCloudy
1          473 446               437 783            271 1004             443 471           471 415
  WB_RBLevelsShade WB_RBLevels6500K WB_RBLevelsCustom WB_RBLevels3500K
1          525 411          490 421           443 471          334 744
                                                                                                                                                                                                 AEMeteringSegments
1 9.875 10 9.875 10.125 10.125 10.125 10 10.25 10 10 10 10 10 10.125 10.125 10.125 10.25 10 10 10.125 10.25 10 10.125 10.125 10.125 9.875 9.875 9.875 9.5 9.875 9.875 9.875 10 9.625 9.625 9.5 9.5 9.375 9.25 9.875
  MeasuredLV                                                           TiffMeteringImage
1       9.75 base64:SUkqAAgAAAAOAP4ABAABAAAAAAAAAAABBAABAAAAKAAAAAEBBAABA[..9819 more..]
  FocusDistance MaxAperture InternalSerialNumber CompressedImageSize PreviewImageStart
1      3.668016    5.656854         702101705900             2284557             27788
  PreviewImageLength SceneMode MinoltaQuality FlashExposureComp Teleconverter RawAndJpgRecording
1              26252        16              2                 0             0                  0
  ZoneMatching ColorTemperature LensType ColorCompensationFilter WhiteBalanceFineTune
1            0                0       24                       0                    3
  ImageStabilization ExposureCompensationSetting HighSpeedSync ShutterSpeedSetting ApertureSetting
1                  1                           0             0          0.00390625        5.656854
  DriveMode2 FocusMode AFPointSelected FlashMode FlashExposureCompSet ISOSetting ZoneMatchingMode
1          5         4               1         0                    0          0                0
  FlashMetering PrioritySetupShutterRelease SelfTimerTime ContinuousBracketing
1             0                           0             0                  771
  SingleFrameBracketing WhiteBalanceSetting PresetWhiteBalance ColorTemperatureSetting
1                   770               32769                  2                       0
  CustomWBSetting DynamicRangeOptimizerSetting FreeMemoryCardImages CustomWBRedLevel
1               0                            1                   99                0
  CustomWBGreenLevel CustomWBBlueLevel CustomWBError SonyImageSize SonyQuality InstantPlaybackTime
1                  0                 0             0             0          32                   2
  InstantPlaybackSetup NoiseReduction EyeStartAF RedEyeReduction FlashDefault AutoBracketOrder
1                    1              1          0               0            0                0
  FocusHoldButton AELButton ControlDialSet AFAssist CardShutterLock LensShutterLock
1               0         0              0        0               1               0
  AFAreaIllumination MonitorDisplayOff RecordDisplay PlayDisplay ExposureIndicator
1                  0                 0             0           0               128
  AELExposureIndicator ExposureBracketingIndicatorLast MeteringOffScaleIndicator
1                    0                               0                         0
  FlashExposureIndicator FlashExposureIndicatorNext FlashExposureIndicatorLast FocusModeSwitch
1                      0                          0                          0               0
  FlashType AELock BatteryState WhiteBalance ColorMode UserComment FlashpixVersion ColorSpace
1         0      0            6           32         0                        0100          1
  ExifImageWidth ExifImageHeight InteropIndex InteropVersion FileSource SceneType CustomRendered
1           3872            2592          R98           0100          3         1              0
  ExposureMode DigitalZoomRatio FocalLengthIn35mmFormat SceneCaptureType GainControl Contrast
1            0                0                     180                0           0        0
  Saturation Sharpness                   XPTitle         XPAuthor
1          0         0 Trafic maritime en Iroise Sandrine Quintin
                                                 XPKeywords                    XPSubject
1 Parc naturel marin d'Iroise, Mer d'Iroise, Agent public,  Transport maritime en Iroise
  PrintIMVersion Compression ThumbnailOffset ThumbnailLength                CurrentIPTCDigest
1           0300           6           25770            2017 0c1465a8a0430b4558f80bbd36992292
                                                                           Keywords DateCreated
1 Trafic maritime,Bateau, Parc naturel marin d'Iroise, Mer d'Iroise, Agent public,   2013:09:14
  DigitalCreationDate          By-line                                                Credit
1          2013:09:14 Sandrine Quintin Sandrine Quintin / Agence des aires marines protegees
            Source    Writer-Editor ApplicationRecordVersion           XMPToolkit
1 Sandrine Quintin Sandrine Quintin                        4 Image::ExifTool 9.08
         LastKeywordIPTC         LastKeywordXMP                      Caption          Creator
1 Trafic maritime,Bateau Trafic maritime,Bateau Transport maritime en Iroise Sandrine Quintin
                   Description                                                Rights
1 Transport maritime en Iroise Sandrine Quintin / Agence des aires marines protegees
                 Subject                     Title           Author    CaptionWriter ImageWidth
1 Trafic maritime,Bateau Trafic maritime en Iroise Sandrine Quintin Sandrine Quintin       3872
  ImageHeight EncodingProcess BitsPerSample ColorComponents YCbCrSubSampling Aperture BlueBalance
1        2592               0             8               3              2 1        8    1.429688
  ImageSize LensID Megapixels
1 3872 2592     24   10.03622
                                                                  PreviewImage RedBalance
1 base64:/9j/2wCEAAgFBgcGBQgHBgcJCAgJDBQNDAsLDBgREg4UHRkeHhwZH[..34951 more..]          2
  ScaleFactor35efl ShutterSpeed
1              1.5       0.0025
                                                               ThumbnailImage CircleOfConfusion
1 base64:/9j/2wDFABAKChAYKDI8DAwOEho6PDYODBAYKDhEOA4QFhwyVlA+/[..2639 more..]        0.02003084
                                DOF                                FOV FocalLength35efl
1 3.52869214310477 3.81879436425615 11.0498994677646 0.709603234563736              180
  HyperfocalDistance LightValue
1           89.86143   14.64386
```
Helper for making maps of species occurrence data
- https://github.com/ropensci/mapr

Petit site sympa pour tester expressions régulières (merci Laura ;) )
- https://regexr.com/

### Visualization
vis_dat helps you visualise a dataframe and “get a look at the data” by displaying the variable classes in a dataframe as a plot with vis_dat, and getting a brief look into missing data patterns using vis_miss.
- https://github.com/ropensci/visdat/blob/master/README.md
Count number of points within polygons / Average value of a field for a set of points within a set of polygons .... /
- https://github.com/ropensci/lawn
Utilities / visualization / themes
- https://github.com/ropensci/landscapetools

#### Création de sites par fiche métadonnées EML
- https://github.com/ropenscilabs/emldown

### Récupération de données :
- Données du hackathon:
  - http://oceanhackathon.indigeo.fr/geocms/maps/oceanhackathon-wpjdbpbc#project
  - http://data.ifremer.fr/pdmi/portalssearch/main
  - http://donnees-campagnes.flotteoceanographique.fr/
  - https://data.shom.fr/donnees#001=eyJjIjpbLTY2MjgwNyw1ODIyOTI3XSwieiI6NiwiciI6MCwibCI6W3sidHlwZSI6IklOVEVSTkFMX0xBWUVSIiwiaWRlbnRpZmllciI6IkZEQ19HRUJDT19QWVItUE5HXzM4NTdfV01UUyIsIm9wYWNpdHkiOjEsInZpc2liaWxpdHkiOnRydWV9XX0=
  - AFB espèces et habitats -> anniebirolo[@]afbiodiversité.fr
- Génomique / Barcode of life : https://github.com/ropensci/bold/blob/master/README.md
- couches environnementales : http://www.ccafs-climate.org/data/

### Standards de métadonnées / Mapping / Spécifications
- EML (https://knb.ecoinformatics.org/#external//emlparser/docs/eml-2.1.1/index.html)
- TETHYS (Passive Accoustic Monitoring) https://tethys.sdsu.edu/
  - "Where possible, we use concepts from ISO 19115 or OpenGIS SensorML3, but our emphasis is on meeting the needs of the marine mammal community in the most user-friendly way possible. As a consequence, we deviate from these standards. In addition, there are many concepts that are not covered in these standards such as recording detection effort."
    - detection effort -> eml attribute / attributetype / measurementscale / interval / precision ?
- Darwin-core https://dwc.tdwg.org/
- ISO19139
  - http://www.geosource.fr/docs/appendix/glossary/iso19139/index.html 
  - https://inspire.ec.europa.eu/id/document/tg/metadata-iso19139
- convertisseurs existants
  - https://github.com/gbif/eml-profile/blob/master/eml2iso19139.xsl
  - https://github.com/NCEAS/iso2eml
  - https://github.com/eblondel/geometa


### Ontologies et liens avec module semantics
#### Sources d'ontologies d'intérêt
- https://bioportal.bioontology.org/
- http://vocabs.lter-europe.net/edg/tbl/EnvThes.editor#http%3A%2F%2Fvocabs.lter-europe.net%2FEnvThes%2F21439
- http://semandiv.agroportal.lirmm.fr/
- http://agroportal.lirmm.fr/annotator
- https://www.rdocumentation.org/packages/AtlasRDF/versions/1.8.0/topics/getOntologyMappings

#### Annotation de données/métadonnées par ontologies :
- annotateur d'ontologies : https://www.bioontology.org/wiki/Annotator_R_Client
- Get mappings for a given class URI from an ontology other than EFO : https://www.rdocumentation.org/packages/AtlasRDF/versions/1.8.0/topics/getOntologyMappings
- ontoCAT: an R package for ontology traversal and search https://academic.oup.com/bioinformatics/article/27/17/2468/223268

### Notion de liens avec provenance via ontologie :
- ontologie provenance : https://www.w3.org/TR/prov-o/ -> voir lien avec notion de provenance dans EML


part 'stock_icon_extension.dart';

/// A type of icon image that ships with Windows per default.
///
/// You should prefer these over the [WinIcon] enum.
///
/// Abriged from https://docs.microsoft.com/en-us/windows/win32/api/shellapi/ne-shellapi-shstockiconid
///
/// Please note that the images in the docs are the ones used in Windows 7,
/// you will get a different style on Windows 10 or 11.
enum StockIcon {
  /// Document of a type with no associated application.
  ///
  /// ![📄](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_docnoassoc.png)
  ///
  /// `SIID_DOCNOASSOC = 0`
  documentOfUnknownType,

  /// Document of a type with an associated application.
  ///
  /// ![📄](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_docassoc.jpg)
  ///
  /// `SIID_DOCASSOC = 1`
  document,

  /// Generic application with no custom icon.
  ///
  /// ![📰](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_appgeneric.jpg)
  ///
  /// `SIID_APPLICATION = 2`
  application,

  /// Folder (generic, unspecified state).
  ///
  /// ![📁](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_folder.jpg)
  ///
  /// `SIID_FOLDER = 3`
  folder,

  /// Folder (open).
  ///
  /// ![📂](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_folderopen.jpg)
  ///
  /// `SIID_FOLDEROPEN = 4`
  folderOpen,

  /// 5.25-inch disk drive.
  ///
  /// ![🖴💾](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_drive525.jpg)
  ///
  /// `SIID_DRIVE525 = 5`
  drive525,

  /// 3.5-inch disk drive.
  ///
  /// ![🖴💾](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_drive35.jpg)
  ///
  /// `SIID_DRIVE35 = 6`
  drive35,

  /// Removable drive.
  ///
  /// ![🖴](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_driveremove.png)
  ///
  /// `SIID_DRIVEREMOVE = 7`
  driveRemovable,

  /// Fixed drive (hard disk).
  ///
  /// ![🖴](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_drivefixed.jpg)
  ///
  /// `SIID_DRIVEFIXED = 8`
  driveFixed,

  /// Network drive (connected).
  ///
  /// ![🖴🔌](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_drivenet.jpg)
  ///
  /// `SIID_DRIVENET = 9`
  driveNetwork,

  /// Network drive (disconnected).
  ///
  /// ![🖴❌](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_drivenetdis.jpg)
  ///
  /// `SIID_DRIVENETDISABLED = 10`
  driveNetworkDisconnected,

  /// CD drive.
  ///
  /// ![🖴💿](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_drivecd.jpg)
  ///
  /// `SIID_DRIVECD = 11`
  driveCd,

  /// RAM disk drive.
  ///
  /// ![🕷️](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_driveram.jpg)
  ///
  /// `SIID_DRIVERAM = 12`
  ramDisk,

  /// The entire network.
  ///
  /// ![🖥️🔗🖥️](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_world.jpg)
  ///
  /// `SIID_WORLD = 13`
  networkLocal,

  /// A computer on the network.
  ///
  /// ![🖥️](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_server.jpg)
  ///
  /// `SIID_SERVER = 15`
  server,

  /// A local printer or print destination.
  ///
  /// ![🖨️](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_printer.jpg)
  ///
  /// `SIID_PRINTER = 16`
  printer,

  /// The Network virtual folder ([FOLDERID_NetworkFolder](https://docs.microsoft.com/en-us/windows/desktop/shell/knownfolderid)/[CSIDL_NETWORK](https://docs.microsoft.com/en-us/windows/desktop/shell/csidl)).
  ///
  /// ![🌍🖥️](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_mynetwork.jpg)
  ///
  /// `SIID_MYNETWORK = 17`
  network,

  /// The **Search** feature.
  ///
  /// ![🔎](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_find.jpg)
  ///
  /// `SIID_FIND = 22`
  search,

  /// The **Help and Support** feature.
  ///
  /// ![ℹ️](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_help.jpg)
  ///
  /// `SIID_HELP = 23`
  help,

  /// Overlay for a shared item.
  ///
  /// ![👨🏽‍🤝‍👨🏿](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_share.jpg)
  ///
  /// `SIID_SHARE = 28`
  shared,

  /// Overlay for a shortcut.
  ///
  /// ![⤴](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_link.jpg)
  ///
  /// `SIID_LINK = 29`
  shortcut,

  /// Overlay for items that are expected to be slow to access.
  ///
  /// ![✖️](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_slowfile.png)
  ///
  /// `SIID_SLOWFILE = 30`
  slowFile,

  /// The Recycle Bin (empty).
  ///
  /// ![🗑](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_recycler.jpg)
  ///
  /// `SIID_RECYCLER = 31`
  trash,

  /// The Recycle Bin (not empty).
  ///
  /// ![🗑](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_recyclerfull.jpg)
  ///
  /// `SIID_RECYCLERFULL = 32`
  trashFull,

  /// Audio CD media.
  ///
  /// ![💿🎶](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_mediacdaudio.jpg)
  ///
  /// `SIID_MEDIACDAUDIO = 40`
  cdAudio,

  /// Security lock.
  ///
  /// ![🔒](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_lock.jpg)
  ///
  /// `SIID_LOCK = 47`
  lock,

  /// A virtual folder that contains the results of a search.
  ///
  /// ![📁🔎](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_autolist.jpg)
  ///
  /// `SIID_AUTOLIST = 49`
  searchFolder,

  /// A network printer.
  ///
  /// ![🖨️🔌](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_printernet.jpg)
  ///
  /// `SIID_PRINTERNET = 50`
  printerNetwork,

  /// A server shared on a network.
  ///
  /// ![📂🔌](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_servershare.jpg)
  ///
  /// `SIID_SERVERSHARE = 51`
  folderNetwork,

  /// A local fax printer.
  ///
  /// ![🖨️](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_printerfax.jpg)
  ///
  /// `SIID_PRINTERFAX = 52`
  faxPrinter,

  /// A network fax printer.
  ///
  /// ![🖨️🔌](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_printerfaxnet.jpg)
  ///
  /// `SIID_PRINTERFAXNET = 53`
  faxPrinterNetwork,

  /// A file that receives the output of a Print to file operation.
  ///
  /// ![🖨️💾](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_printerfile.jpg)
  ///
  /// `SIID_PRINTERFILE = 54`
  printToFile,

  /// A category that results from a Stack by command to organize the contents of a folder.
  ///
  /// ![🗂️](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_stack.jpg)
  ///
  /// `SIID_STACK = 55`
  stack,

  /// Super Video CD (SVCD) media.
  ///
  /// ![💿🎞️](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_mediasvcd.jpg)
  ///
  /// `SIID_MEDIASVCD = 56`
  superVideoCd,

  /// A folder that contains only subfolders as child items.
  ///
  /// ![📁🥨](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_stuffedfolder.jpg)
  ///
  /// `SIID_STUFFEDFOLDER = 57`
  folderStuffed,

  /// Unknown drive type.
  ///
  /// ![🖴❔](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_driveunknown.jpg)
  ///
  /// `SIID_DRIVEUNKNOWN = 58`
  driveUnknown,

  /// DVD drive.
  ///
  /// ![🖴💿](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_drivedvd.jpg)
  ///
  /// `SIID_DRIVEDVD = 59`
  driveDvd,

  /// DVD media.
  ///
  /// ![💿](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_mediadvd.jpg)
  ///
  /// `SIID_MEDIADVD = 60`
  dvd,

  /// DVD-RAM media.
  ///
  /// ![💿](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_mediadvdram.jpg)
  ///
  /// `SIID_MEDIADVDRAM = 61`
  dvdRam,

  /// DVD-RW media.
  ///
  /// ![💿🖊️](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_mediadvdrw.jpg)
  ///
  /// `SIID_MEDIADVDRW = 62`
  dvdRw,

  /// DVD-R media.
  ///
  /// ![💿👁️‍🗨️](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_mediadvdr.jpg)
  ///
  /// `SIID_MEDIADVDR = 63`
  dvdR,

  /// DVD-ROM media.
  ///
  /// ![💿👁️‍🗨️](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_mediadvdrom.jpg)
  ///
  /// `SIID_MEDIADVDROM = 64`
  dvdRom,

  /// CD+ (enhanced audio CD) media.
  ///
  /// ![💽➕🎶](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_mediacdplus.jpg)
  ///
  /// `SIID_MEDIACDAUDIOPLUS = 65`
  cdPlus,

  /// CD-RW media.
  ///
  /// ![💽🖊️](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_mediacdrw.jpg)
  ///
  /// `SIID_MEDIACDRW = 66`
  cdRw,

  /// CD-R media.
  ///
  /// ![💽👁️‍🗨️](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_mediacdr.jpg)
  ///
  /// `SIID_MEDIACDR = 67`
  cdR,

  /// A writable CD in the process of being burned.
  ///
  /// ![💽🔥](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_mediacdburn.jpg)
  ///
  /// `SIID_MEDIACDBURN = 68`
  cdBurn,

  /// Blank writable CD media.
  ///
  /// ![💽✨](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_mediablankcd.jpg)
  ///
  /// `SIID_MEDIACDBLANK = 69`
  cdBlank,

  /// CD-ROM media.
  ///
  /// ![💽👁️‍🗨️](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_mediacdrom.jpg)
  ///
  /// `SIID_MEDIACDROM = 70`
  cdRom,

  /// An audio file.
  ///
  /// ![🎵📄](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_audiofiles.jpg)
  ///
  /// `SIID_AUDIOFILES = 71`
  audioFile,

  /// An image file.
  ///
  /// ![🖼️📄](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_imagefiles.jpg)
  ///
  /// `SIID_IMAGEFILE = 72`
  imageFile,

  /// A video file.
  ///
  /// ![🎞️📄](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_videofiles.jpg)
  ///
  /// `SIID_VIDEOFILES = 73`
  videoFile,

  /// A mixed file.
  ///
  /// ![🎞️🎵📄](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_mixedfiles.jpg)
  ///
  /// `SIID_MIXEDFILES = 74`
  mixedFile,

  /// Folder back.
  ///
  /// ![📂🔙](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_folderback.jpg)
  ///
  /// `SIID_FOLDERBACK = 75`
  folderBack,

  /// Folder front.
  ///
  /// ![📂](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_folderfront.jpg)
  ///
  /// `SIID_FOLDERFRONT = 76`
  folderFront,

  /// Security shield. Use for UAC prompts only.
  ///
  /// ![🛡️](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_shield.jpg)
  ///
  /// `SIID_SHIELD = 77`
  shield,

  /// Warning.
  ///
  /// ![⚠️](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_warning.jpg)
  ///
  /// `SIID_WARNING = 78`
  warning,

  /// Informational.
  ///
  /// ![ℹ️](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_info.jpg)
  ///
  /// `SIID_INFO = 79`
  info,

  /// Error.
  ///
  /// ![❌](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_error.jpg)
  ///
  /// `SIID_ERROR = 80`
  error,

  /// Key.
  ///
  /// ![🔑](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_key.jpg)
  ///
  /// `SIID_KEY = 81`
  key,

  /// Software.
  ///
  /// ![📦](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_software.jpg)
  ///
  /// `SIID_SOFTWARE = 82`
  software,

  /// Rename.
  ///
  /// ![🖊️](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_rename.jpg)
  ///
  /// `SIID_RENAME = 83`
  rename,

  /// Delete.
  ///
  /// ![❌](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_delete.jpg)
  ///
  /// `SIID_DELETE = 84`
  delete,

  /// Audio DVD media.
  ///
  /// ![💿🎶](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_mediaaudiodvd.jpg)
  ///
  /// `SIID_MEDIAAUDIODVD = 85`
  audioDvd,

  /// Movie DVD media.
  ///
  /// ![💿🎞️](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_mediamoviedvd.jpg)
  ///
  /// `SIID_MEDIAMOVIEDVD = 86`
  movieDvd,

  /// Enhanced CD media.
  ///
  /// ![💽🎶](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_mediaenhancedcd.jpg)
  ///
  /// `SIID_MEDIAENHANCEDCD = 87`
  enhancedCd,

  /// Enhanced DVD media.
  ///
  /// ![💿🎞️](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_mediaenhanceddvd.jpg)
  ///
  /// `SIID_MEDIAENHANCEDDVD = 88`
  enhancedDvd,

  /// High definition DVD media in the HD DVD format.
  ///
  /// ![💿🎞️](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_mediahddvd.jpg)
  ///
  /// `SIID_MEDIAHDDVD = 89`
  hdDvd,

  /// High definition DVD media in the Blu-ray Disc™ format.
  ///
  /// ![💿🎞️](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_mediabluray.jpg)
  ///
  /// `SIID_MEDIABLURAY = 90`
  bluRay,

  /// Video CD (VCD) media.
  ///
  /// ![💽🎞️](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_mediavcd.jpg)
  ///
  /// `SIID_MEDIAVCD = 91`
  videoCd,

  /// DVD+R media.
  ///
  /// ![💿](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_mediadvdplusr.jpg)
  ///
  /// `SIID_MEDIADVDPLUSR = 92`
  dvdPlusR,

  /// DVD+RW media.
  ///
  /// ![💿](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_mediadvdplusrw.jpg)
  ///
  /// `SIID_MEDIADVDPLUSRW = 93`
  dvdPlusRw,

  /// A desktop computer.
  ///
  /// ![🖥️](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_desktoppc.jpg)
  ///
  /// `SIID_DESKTOPPC = 94`
  desktopComputer,

  /// A mobile computer (laptop).
  ///
  /// ![💻](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_mobilepc.jpg)
  ///
  /// This icon might be missing or display blank.
  ///
  /// `SIID_MOBILEPC = 95`
  laptop,

  /// The **User Accounts** Control Panel item.
  ///
  /// ![👨‍👩‍👧](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_users.jpg)
  ///
  /// `SIID_USERS = 96`
  users,

  /// Smart media.
  ///
  /// ![💾🧠](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_mediasmartmedia.jpg)
  ///
  /// `SIID_MEDIASMARTMEDIA = 97`
  smartMedia,

  /// CompactFlash media.
  ///
  /// ![☄️](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_compactflash.jpg)
  ///
  /// `SIID_MEDIACOMPACTFLASH = 98`
  compactFlash,

  /// A cell phone.
  ///
  /// ![📱](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_devicecellphone.jpg)
  ///
  /// `SIID_DEVICECELLPHONE = 99`
  cellPhone,

  /// A digital camera.
  ///
  /// ![📷](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_devicecamera.jpg)
  ///
  /// `SIID_DEVICECAMERA = 100`
  camera,

  /// A digital video camera.
  ///
  /// ![📷](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_devicevideocamera.jpg)
  ///
  /// `SIID_DEVICEVIDEOCAMERA = 101`
  videoCamera,

  /// An audio player.
  ///
  /// ![📻](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_deviceaudioplayer.jpg)
  ///
  /// `SIID_DEVICEAUDIOPLAYER = 102`
  audioPlayer,

  /// Connect to network.
  ///
  /// ![🖥️↔️🖥️](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_networkconnect.jpg)
  ///
  /// `SIID_NETWORKCONNECT = 103`
  networkConnect,

  /// The **Network and Internet** Control Panel item.
  ///
  /// ![🌐](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_internet.jpg)
  ///
  /// `SIID_internet = 104`
  internet,

  /// A compressed file with a .zip file name extension.
  ///
  /// ![🗜️📁](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_zipfile.jpg)
  ///
  /// `SIID_ZIPFILE = 105`
  zipFile,

  /// The **Additional Options** Control Panel item.
  ///
  /// ![⚙️](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_settings.jpg)
  ///
  /// This icon might be missing or display blank.
  ///
  /// `SIID_SETTINGS = 106`
  settings,

  /// High definition DVD drive (any type - HD DVD-ROM, HD DVD-R, HD-DVD-RAM) that uses the HD DVD format.
  ///
  /// Windows Vista with Service Pack 1 (SP1) and later.
  ///
  /// ![🖴💿](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_mediahddvd.jpg)
  ///
  /// `SIID_DRIVEHDDVD = 132`
  driveHdDvd,

  /// High definition DVD drive (any type - BD-ROM, BD-R, BD-RE) that uses the Blu-ray Disc format.
  ///
  /// Windows Vista with Service Pack 1 (SP1) and later.
  ///
  /// ![🖴💿](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_drivebd.jpg)
  ///
  /// `SIID_DRIVEBD = 133`
  driveBd,

  /// High definition DVD-ROM media in the HD DVD-ROM format.
  ///
  /// Windows Vista with Service Pack 1 (SP1) and later.
  ///
  /// ![💿👁️‍🗨️](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_mediahddvdrom.jpg)
  ///
  /// `SIID_MEDIAHDDVDROM = 134`
  hdDvdRom,

  /// High definition DVD-R media in the HD DVD-R format.
  ///
  /// Windows Vista with Service Pack 1 (SP1) and later.
  ///
  /// ![💿👁️‍🗨️](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_mediahddvdr.jpg)
  ///
  /// `SIID_MEDIAHDDVDR = 135`
  hdDvdR,

  /// High definition DVD-RAM media in the HD DVD-RAM format.
  ///
  /// Windows Vista with Service Pack 1 (SP1) and later.
  ///
  /// ![💿](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_mediahddvdram.jpg)
  ///
  /// `SIID_MEDIAHDDVDRAM = 136`
  hdDvdRam,

  /// High definition DVD-ROM media in the Blu-ray Disc BD-ROM format.
  ///
  /// Windows Vista with Service Pack 1 (SP1) and later.
  ///
  /// ![💿👁️‍🗨️](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_mediabdrom.jpg)
  ///
  /// `SIID_MEDIABDROM = 137`
  bdRom,

  /// High definition DVD-R media in the Blu-ray Disc BD-R format.
  ///
  /// Windows Vista with Service Pack 1 (SP1) and later.
  ///
  /// ![💿👁️‍🗨️](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_mediabdr.jpg)
  ///
  /// `SIID_MEDIABDR = 138`
  bdR,

  /// High definition read/write media in the Blu-ray Disc BD-RE format.
  ///
  /// Windows Vista with Service Pack 1 (SP1) and later.
  ///
  /// ![💿👁️‍🗨️](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_mediabdre.jpg)
  ///
  /// `SIID_MEDIABDRE = 139`
  bdRe,

  /// A cluster disk array.
  ///
  /// Windows Vista with Service Pack 1 (SP1) and later.
  ///
  /// ![🖴](https://docs.microsoft.com/en-us/windows/win32/api/shellapi/images/siid_clustereddrive.jpg)
  ///
  /// `SIID_CLUSTEREDDRIVE = 140`
  clusteredDrive,
}

# Changelog

### [1.2.3](https://github.com/benthillerkus/betrayal/compare/v1.2.2...v1.2.3) (2022-04-20)


### Documentation

* fix typo in generic description for enum extensions ([47c01c0](https://github.com/benthillerkus/betrayal/commit/47c01c0a48e01626cbdd04f7a84c66bd35ebe28b))


### Miscellaneous

* **pubspec:** slightly reduce cringiness of description ([78e47f6](https://github.com/benthillerkus/betrayal/commit/78e47f653eb19d26f9c9d9d7a4e05159f7a19101)), closes [#24](https://github.com/benthillerkus/betrayal/issues/24)
* update deps, format file ([03ca002](https://github.com/benthillerkus/betrayal/commit/03ca002b6bad9abec47207790ad437a04ff22dbd))

### [1.2.2](https://github.com/benthillerkus/betrayal/compare/v1.2.1...v1.2.2) (2022-04-18)


### Miscellaneous

* **pubspec:** fix typo ([1210cdc](https://github.com/benthillerkus/betrayal/commit/1210cdce271bcf5c73cf0347277e38d0b8af111f))
* **pubspec:** improve metadata for pub.dev ([6e9309d](https://github.com/benthillerkus/betrayal/commit/6e9309d89d2eea88e17868ea7c72baefa5c9fd0a))


### Documentation

* **pubspec:** add example readme as link to external documentation ([1f740bc](https://github.com/benthillerkus/betrayal/commit/1f740bc8a494ee5307509743ca9367cd484a60ad))
* **readme:** improve readability a bit ([ce33aff](https://github.com/benthillerkus/betrayal/commit/ce33aff5a7364d827ff58ee0b7fb406dd23a2b59))

### [1.2.1](https://github.com/benthillerkus/betrayal/compare/v1.2.0...v1.2.1) (2022-04-18)


### Bug Fixes

* improve code quality for custom ids feature ([35583f7](https://github.com/benthillerkus/betrayal/commit/35583f7fdd4e583d832af32cbcaed27e237a0c51))
* **native:** let Windows handle all unhandled user type messages ([22625a4](https://github.com/benthillerkus/betrayal/commit/22625a46a9a2bd8ca03b62cc1ca11a8dce5cf98d))


### Documentation

* **example:** make `add_many` example more understandable ([5cadfb8](https://github.com/benthillerkus/betrayal/commit/5cadfb8f53446d98fede979d702394c8d023d337))

## [1.2.0](https://github.com/benthillerkus/betrayal/compare/v1.1.0...v1.2.0) (2022-04-18)


### Features

* allow setting a custom value for icon id ([829c287](https://github.com/benthillerkus/betrayal/commit/829c287a866dc1688720bdb34a95584d35ae4042))


### Bug Fixes

* don't return default values for `preferredImageSize` ([b2540f2](https://github.com/benthillerkus/betrayal/commit/b2540f26197d93dd388f5e37e0ba650519bd43c8)), closes [#10](https://github.com/benthillerkus/betrayal/issues/10)

## [1.1.0](https://github.com/benthillerkus/betrayal/compare/v1.0.0...v1.1.0) (2022-04-17)


### ⚠ BREAKING CHANGES

* `BetrayalPlugin()` and `BetrayalLogConfig()` have been replaced with `.instance` respectively.

### Bug Fixes

* remove unused import ([bb52101](https://github.com/benthillerkus/betrayal/commit/bb52101a35a9bb94360a28eace44779720c80298))


### Documentation

* **example:** `add_many` visualize all icons as a grid ([315aa0f](https://github.com/benthillerkus/betrayal/commit/315aa0f9e7b0bfe7cbe4d3984f30d587a4fd7a66))
* **example:** refactor add_many example. ([cca1c42](https://github.com/benthillerkus/betrayal/commit/cca1c4235e247782eb6c644494c1ff304998bbdb))
* **readme:** add short section about hot restart ([0e52401](https://github.com/benthillerkus/betrayal/commit/0e524019c94571bb4ca6eee337f5aec309c823eb))


### Miscellaneous

* **branding:** improve font kerning in art assets ([18fbd94](https://github.com/benthillerkus/betrayal/commit/18fbd9427addb759fb9063e7a41b642d8a9d4f17))
* make singletons explicit ([772730e](https://github.com/benthillerkus/betrayal/commit/772730e153661a9461e6b5e198161f2bf1df0e62))
* mark `.instance`s as protected ([7d9dafd](https://github.com/benthillerkus/betrayal/commit/7d9dafdf57070410d9dd188b728b3d0ba7e8878a))

## [1.0.0](https://github.com/benthillerkus/betrayal/compare/v1.0.0-dev.7...v1.0.0) (2022-04-15)


### Documentation

* **readme:** add demo video ([4d95454](https://github.com/benthillerkus/betrayal/commit/4d9545474ceddd9eed92bd0f31912dc2973f126f))
* **readme:** use assets to make readme a bit prettier ([1a5094f](https://github.com/benthillerkus/betrayal/commit/1a5094f179fa5de9893d10c7a9c626a7fbc57133))
* upload assets ([82a5946](https://github.com/benthillerkus/betrayal/commit/82a5946936043f7c3fd836952e00ea6addb28a8c))

## [1.0.0-dev.7](https://github.com/benthillerkus/betrayal/compare/v1.0.0-dev.6...v1.0.0-dev.7) (2022-04-14)


### ⚠ BREAKING CHANGES

* The internal API for [_TrayIconInteraction](https://github.com/benthillerkus/betrayal/blob/b83703b7c56095ee2eca74a7e53436fa773789fd/lib/src/interaction.dart#L19-L20) changed by introducing the new [rawEvent].

### Features

* retrieve the correct icon dimensions ([e8fed3b](https://github.com/benthillerkus/betrayal/commit/e8fed3b012cdf3489d7754b3e3a7a4c7c977be7a))


### Bug Fixes

* ensure that setting onTap on a not-yet-realized icon is safe ([5d2a1d6](https://github.com/benthillerkus/betrayal/commit/5d2a1d6bff2acc9aeb052352e6d0b1d0496880fd))
* make getter for large image size return \"\" ([f01d655](https://github.com/benthillerkus/betrayal/commit/f01d65587e9f517d824b1154f06edc2013881f5a))


### Miscellaneous

* update some lock file ([393759d](https://github.com/benthillerkus/betrayal/commit/393759d1f5a2c2c3384545160957d3780aaff2f9))


### Documentation

* **example:** finish renaming into `select_image` ([95db76e](https://github.com/benthillerkus/betrayal/commit/95db76ed3a4be01eb51a472c61b612bb29c606eb))
* **example:** improve downscaling quality ([0c08f84](https://github.com/benthillerkus/betrayal/commit/0c08f84bc51fb1845b08781ea78f1ab0b238d6cb))
* **example:** rename `edit_icon` into `select_image` ([5e377ea](https://github.com/benthillerkus/betrayal/commit/5e377eaedd0c66774dc92c272fb9e1c8862e76ba))

## [1.0.0-dev.6](https://github.com/benthillerkus/betrayal/compare/v1.0.0-dev.5...v1.0.0-dev.6) (2022-04-12)


### Features

* introduce support for interactions ([f927a35](https://github.com/benthillerkus/betrayal/commit/f927a35f6354fa498a6e1ae8a5b759b7ccb6f6dc))


### Documentation

* fix broken image links ([1a7104c](https://github.com/benthillerkus/betrayal/commit/1a7104cb790223eff84066ad8976c02863633cf0))
* improve generation setting ([02efff9](https://github.com/benthillerkus/betrayal/commit/02efff94c752b90cb1edb5f29bb817b465359923))
* **readme:** +1 for fanciness ([0242703](https://github.com/benthillerkus/betrayal/commit/02427033421e223acd45530622fa8b7d2ce06b93))

## [1.0.0-dev.5](https://github.com/benthillerkus/betrayal/compare/v1.0.0-dev.4...v1.0.0-dev.5) (2022-04-10)


### Bug Fixes

* remove emoji from `pubspec.yaml` ([a24b827](https://github.com/benthillerkus/betrayal/commit/a24b8271cdf781aa91bd41799423276cf19831a4))


### Documentation

* **readme:** implement further advances in fanciness ([5e1f055](https://github.com/benthillerkus/betrayal/commit/5e1f055deb35391fec76fed6802a63da24f8fde9))

## [1.0.0-dev.4](https://github.com/benthillerkus/betrayal/compare/v1.0.0-dev.3...v1.0.0-dev.4) (2022-04-10)


### Features

* support windows stock icons ([9e0da85](https://github.com/benthillerkus/betrayal/commit/9e0da856d5e07553d5863b9e2ab9bec9f4d190e1))


### Bug Fixes

* forgot to check in some method into sc ([aadab96](https://github.com/benthillerkus/betrayal/commit/aadab9610e0616a9de6dfff70f84c6717663b5f1))


### Miscellaneous

* improve code quality ([ca915e2](https://github.com/benthillerkus/betrayal/commit/ca915e29e5e35285bace9762bebc60083adc8c23))
* **publish:** fix run rules ([073dd81](https://github.com/benthillerkus/betrayal/commit/073dd817bbfaed03650e5bcdbcf00378ffcb5550))


### Documentation

* **readme:** add some light fanciness ([a38db9b](https://github.com/benthillerkus/betrayal/commit/a38db9b62ea2fd73519e18e5ed71564736c65cf9))
* **readme:** increase fanciness even further by doubling the amount of badges ([1362669](https://github.com/benthillerkus/betrayal/commit/13626695fa0039097108d69ac36f4ab54adff750))
* **readme:** make badges clickable ([1bfcd8e](https://github.com/benthillerkus/betrayal/commit/1bfcd8e69508fbbdada6f9a97aabe4d95baaaf27))
* **readme:** replace score badge ([b965602](https://github.com/benthillerkus/betrayal/commit/b96560216c97f7505575a9c07263bf276eed10a2))

## [1.0.0-dev.3](https://github.com/benthillerkus/betrayal/compare/v1.0.0-dev.2...v1.0.0-dev.3) (2022-04-10)


### Documentation

* **readme:** change relative links to link to gh ([57780fd](https://github.com/benthillerkus/betrayal/commit/57780fd7c4ac70ca3ba5ecf6d30c5d2642af8b7b))

## [1.0.0-dev.2](https://github.com/benthillerkus/betrayal/compare/v1.0.0-dev.1...v1.0.0-dev.2) (2022-04-10)


### Bug Fixes

* add `path` as an explicit dependency ([2b4f8d2](https://github.com/benthillerkus/betrayal/commit/2b4f8d2701259536a71031ce52d2dfad43d10733))
* **page:** move page to main directory ([f18b844](https://github.com/benthillerkus/betrayal/commit/f18b8443a96a0a1276ec218e98eed888d93ab3d0))


### Miscellaneous Chores

* prepare new preview release ([b2b6c54](https://github.com/benthillerkus/betrayal/commit/b2b6c54bace8701f36a1ce1929720bea396292b1))

## 1.0.0-dev.1 (2022-04-10)


### ⚠ BREAKING CHANGES

* **plugin:** remove `TrayIconData`
* **api:** make `TrayIconImageDelegate` named parameter name in `setIcon` less verbose
* **plugin:** `image`, `picture` and `freeRessources` have been removed. Users have to pass a `ByteBuffer` now instead.
* **plugin:** disable image cleanup per default
* **example:** turn `builder` from a positional parameter into an optional named parameter
* **example:** the `ElementSelector` related widgets need to be imported now.
* **example:** The `Element Selector` widget api changed a bit.
* basically everything 🤏

### Features

* add logging ([89360e9](https://github.com/benthillerkus/betrayal/commit/89360e9a451a5d5f560deb4d19a7a9fb1d088e52))
* **api:** make `TrayIconImageDelegate` public ([64d945f](https://github.com/benthillerkus/betrayal/commit/64d945fa9217aa778a518cb6f0c2449ad133b73e))
* **example:** add labels to `Selector` view ([e5b8a24](https://github.com/benthillerkus/betrayal/commit/e5b8a2449694cff1fb863c6bad50723cfaedfb84))
* **example:** allow subclassing `ElementSelectorData` to add additional fields ([b816880](https://github.com/benthillerkus/betrayal/commit/b8168807c6c0ea5365333dbb1c06bec360390025))
* **example:** change tray icon when selection changes ([8b0fdae](https://github.com/benthillerkus/betrayal/commit/8b0fdaef3b9e5a70853c29aa31564158b634cd0a))
* **example:** hide icon when every `Selectable` has been removed ([6eaaf73](https://github.com/benthillerkus/betrayal/commit/6eaaf730b63e015589136736f84ceda40262e11f))
* **example:** make tooltip / label text changeable ([786cf5a](https://github.com/benthillerkus/betrayal/commit/786cf5a26b8fb6c029b617d806980feb4f7d583d))
* **example:** move example specific logic out of `ElementSelector`. ([16875ea](https://github.com/benthillerkus/betrayal/commit/16875ea442b82059f3d18a2c7cbad3a602cd78dd))
* **example:** set loaded image as icon image ([20f3fcd](https://github.com/benthillerkus/betrayal/commit/20f3fcd43cff0a65ce4505e59652ab672b3524a8))
* introduce widgets api ([74c1d31](https://github.com/benthillerkus/betrayal/commit/74c1d31bcc2124af71371c2e7f74df371f94dd56))
* make logging customizable ([439909a](https://github.com/benthillerkus/betrayal/commit/439909af1ef5862a379d1a77bfe23bf38d5ddbed))


### Bug Fixes

* **example:** animate label out after removing icon ([07dcdc6](https://github.com/benthillerkus/betrayal/commit/07dcdc659d42de771eaedfb7e6fc78e28035693b))
* **example:** don't hide icon after every removal ([5410e5d](https://github.com/benthillerkus/betrayal/commit/5410e5def81a8da32698894a7a1104472b434a49))
* **example:** keep the last element selected, when the current view is the plus icon ([d5d03d8](https://github.com/benthillerkus/betrayal/commit/d5d03d869a906dd85ea5e3fc6ba4346d07595fa3))
* **example:** make `Selectable` widget immutable ([5faecae](https://github.com/benthillerkus/betrayal/commit/5faecaecb45d422e88e716a5f60c104a8b87b5ba))
* **example:** select the correct element after removing the selection ([9d12e73](https://github.com/benthillerkus/betrayal/commit/9d12e737e5ef001cdbc36a7d228437e762b36828))
* **example:** show tray icon immediately. The user does not have to change their selection first ([7ad2993](https://github.com/benthillerkus/betrayal/commit/7ad29930e0243352c0a81d6165d6b0a966871bcc))
* **example:** update configuration / dependencies ([471c171](https://github.com/benthillerkus/betrayal/commit/471c1715790ce3f8aeee65aa8c59eba52c6edad0))
* **plugin:** call `update` on icon after changing tooltip ([ed3b9fe](https://github.com/benthillerkus/betrayal/commit/ed3b9fe2854c6c5063a347986d5672eadef5ff0d))
* **plugin:** clear icons on hot restart ([bc9484d](https://github.com/benthillerkus/betrayal/commit/bc9484d6f85eb1b2ce15dcdd994a879ab9dc4aaf))
* **plugin:** disable image cleanup per default ([b0f4447](https://github.com/benthillerkus/betrayal/commit/b0f4447a91fa18c6fd6b6904484cc4742c889a0a))
* **windows:** call `icon->update` whenever any property is being changed ([50ee78e](https://github.com/benthillerkus/betrayal/commit/50ee78e00d0afe882a0809a4f85690eed815b5af))


### Code Refactoring

* **plugin:** remove `TrayIconData` ([743a2b5](https://github.com/benthillerkus/betrayal/commit/743a2b5b98f78b0ef1e6497cf9050e62190da885))


### Miscellaneous Chores

* **api:** make `TrayIconImageDelegate` named parameter name in `setIcon` less verbose ([6195752](https://github.com/benthillerkus/betrayal/commit/6195752b1e95dcb45509f6201db8ad3a759b5903))
* **example:** move the `ElementSelector` related classes into seperate files ([ca93fa8](https://github.com/benthillerkus/betrayal/commit/ca93fa8c97e3936b57204e5086f15e300a492194))
* **example:** turn `builder` from a positional parameter into an optional named parameter ([3f51b06](https://github.com/benthillerkus/betrayal/commit/3f51b06fd70eec94c5172ff021a9c0ab4f4fb897))
* make an initial commit ([2628331](https://github.com/benthillerkus/betrayal/commit/262833110bb3aa45e48f22e4087d34e4fa5b6e83))
* **plugin:** delegate setting the icon image to new `TrayIconImageDelegate` ([dd7690e](https://github.com/benthillerkus/betrayal/commit/dd7690e46c9255f449241bd635b64c272a83acba))
* prepare publishing a preview version ([420db07](https://github.com/benthillerkus/betrayal/commit/420db07f25fc77dd4fbe1c9c34c13ebb208d4ca9))

# Changelog

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

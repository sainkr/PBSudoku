[![CI Status](https://img.shields.io/travis/sainkr/PBSudoku.svg?style=flat)](https://travis-ci.org/sainkr/PBSudoku)
[![Version](https://img.shields.io/cocoapods/v/PBSudoku.svg?style=flat)](https://cocoapods.org/pods/PBSudoku)
[![License](https://img.shields.io/cocoapods/l/PBSudoku.svg?style=flat)](https://cocoapods.org/pods/PBSudoku)
[![Platform](https://img.shields.io/cocoapods/p/PBSudoku.svg?style=flat)](https://cocoapods.org/pods/PBSudoku)

# PBSudoku
스도쿠 생성 라이브러리입니다.

## Installation

PBSudoku is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'PBSudoku'
```

## Usage
- Level을 설정해줍니다. 1,2,3 레벨이 존재하며 이 외의 레벨 입력 시 Level이 3인 스도쿠가 생성됩니다.
```swift
public func setLevel(level : Int)
```
- 설정한 Level을 확인할 수 있습니다.
```swift
public var level = 0
```
- 빈칸이 생성되지 않은 스도쿠를 확인할 수 있습니다.
```swift
public var original_sudoku: [[Int]] = []
```
- 빈칸이 생성된 스도쿠를 확인할 수 있습니다.
```swift
public var game_sudoku: [[Int]] = []
```

## Demo code
```swift
sudoku.setLevel(level: <Your Level: Int>)
let original_sudoku = sudoku.original_sudoku
let game_sudoku = sudoku.game_sudoku
```

## Author

sainkr, raebadnap@naver.com

## License

PBSudoku is available under the MIT license. See the LICENSE file for more info.

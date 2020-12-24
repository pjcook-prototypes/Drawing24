//
//  Day23.swift
//  DrawingTests
//
//  Created by PJ on 24/12/2020.
//  Copyright © 2020 Software101. All rights reserved.
//

import XCTest
@testable import Drawing24

class Day24Tests: XCTestCase {
    let day = Day24()
    
    func test() {
        let input = """
        sesenwnenenewseeswwswswwnenewsewsw
        neeenesenwnwwswnenewnwwsewnenwseswesw
        seswneswswsenwwnwse
        nwnwneseeswswnenewneswwnewseswneseene
        swweswneswnenwsewnwneneseenw
        eesenwseswswnenwswnwnwsewwnwsene
        sewnenenenesenwsewnenwwwse
        wenwwweseeeweswwwnwwe
        wsweesenenewnwwnwsenewsenwwsesesenwne
        neeswseenwwswnwswswnw
        nenwswwsewswnenenewsenwsenwnesesenew
        enewnwewneswsewnwswenweswnenwsenwsw
        sweneswneswneneenwnewenewwneswswnese
        swwesenesewenwneswnwwneseswwne
        enesenwswwswneneswsenwnewswseenwsese
        wnwnesenesenenwwnenwsewesewsesesew
        nenewswnwewswnenesenwnesewesw
        eneswnwswnwsenenwnwnwwseeswneewsenese
        neswnwewnwnwseenwseesewsenwsweewe
        wseweeenwnesenwwwswnew
        """.lines

        let instructions = day.parse(input)
        XCTAssertEqual(2208, day.part2(instructions))
    }
    
    func test_drawing() {
        var floor = Day24.Floor()
        floor[.zero] = .white
        floor[.zero + Day24.HexDirection.northeast.point] = .black
        day.draw(floor)
    }

}

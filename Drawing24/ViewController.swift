import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var label: UILabel!
    
    private var day = Day24()
    private var running = false
    private var imageNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        day.displayImage = displayImage
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(documentsDirectory())
        run()
    }

    private func displayImage(_ image: UIImage) {
        DispatchQueue.main.async {
            if image.size != .zero {
                self.imageView.image = image
                self.saveImage(image)
            } else {
                print("Invalid image")
            }
        }
    }
    
    private func saveImage(_ image: UIImage) {
        let directory = documentsDirectory()
        let filename = directory.appendingPathComponent("image\(imageNumber).png")
        try? image.pngData()?.write(to: filename)
        imageNumber += 1
    }
    
    private func documentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
    
    private func run() {
        guard !running else { return }
        running = true
        imageView.image = nil
        imageNumber = 0
        label.text = "Running"
        DispatchQueue.global().async {
            let input = """
            seseswnwseneweseswseswnwnese
            neneeneseneeeesenewwne
            swswswneswsewswseswesewswseswneeswswnwsw
            eneeswnwneneenwneneneeneneswnwneswne
            seeseseeeeseenenenwswseweese
            seswweseseseswseswneswwnwswswseneswnw
            wswseswswneeswswsw
            wnewnwnewwwwwwwwwsewwsw
            wseswnenwneswwnwseeenwnwnwewesewse
            seweseseneeeseeswsenwseeenwseeeew
            seswswnwswswswnesesesewseeneseswsesesesw
            wsenewsenwwnewswwewnwnwsewwwsw
            swwwnewnwwseswswnwswenwswseeswesw
            senenwswwnwnewwseseseswswwweneswwne
            nwseseeeesweee
            swwswswswwswswsweswnwwswsw
            sewnwswneneneenenewneeneeneneswwee
            swenenwswnwnenwnwnwenwnenesenwnenwnwnwwnw
            eweeneswnesenesewneneeeneseneneew
            enesesenwsweeeeeenwnwnwsweswew
            nweeeswneswenwseswnweeeneenenesw
            neeeswnwnenwnewnwnwswenwwwnwsesenw
            neswnwenwneswnwnwnwneswnesenwnw
            neeseeweneeswweeswneneneeneenenw
            nenwnenwnenwewnewsenwnwnwnwnene
            nwewnwnwwnenwnwwnwnwwnwwenwnwsenw
            seseswsewneswseseseseseswwseseswe
            eseswnewenwwnenene
            wswneneswswsewnwseswswswseswswwwswswne
            neeswneneewnenenenenwnewneeeneneswse
            eneeneneneneeeneneenewsene
            eneweewwsenesene
            nwenwenwnwswnenwsenwnesenenenenwnesw
            wesenesenewweewwwswwnwsew
            eeswneeewsewneneneweneeneene
            eeswswswnwweswnenwsw
            swesewnwneswseesesesesesenwsenwesee
            enwsenwnwswnwwnwseseseseeswewnesenw
            eeseeeseenwseenweeeenwesese
            nenwnwswneneswneenenwneneswnenwnwnwnenee
            ewswwswwswewwnwwenww
            swnenenwnenenenesenenesewnenwnenwesenesw
            nwseeenwnwwnwnwenwswnwswnwnwneenwnew
            ewwnwwwwnwswnwnenwsenwnwewnwww
            eswwwseewsewweeswwnwnwwenwwwne
            wswseswswswnenwswwswswnewswswse
            nwnenwseseswsesesenwseseseweswew
            swesweenenwnwnenwnenwwneneseenenwsw
            wswwwswneswwwswwewnenwswwwew
            wsewwwnwwwwnwsenenewnwewwsw
            wswswwesweswnwswwwswswsweswswswsw
            eswswwnwwswsesweswswswneswswnwnwsesw
            neenwsewwswneseswwseswnwwwwswww
            enwseweseseseeswseneneseswseswneee
            swnwswswneseswswswsesewseseneneseswsee
            wsenwwswwwnwswwwwneswewwneww
            nweswsweeewnenesee
            swsweswnwswseneswswswseswswswsw
            swsewseswseeseneeswswwswswnenenwnesesw
            seeeenenewenenenenesew
            nwnesewsesesenwsesenwsenwnwnenwnenwnww
            enwswsewnesesesenwe
            nwnwnesenwwwwnwnw
            nenesenewneenenenenwswneenesenenwnewne
            wnwnesenenwesewsenenenenwneeeneswse
            wwswswswswswswwswwswesww
            enwsesesewseeesweneeeswesesweenw
            wwnwseneneneeenewswnwnwneswsenewnwsenw
            swswswswswswewswswwswsww
            nenwwnenwsenwnwswseswnwneneseseesenww
            seeseeseeeesenewseswweseseswnenese
            wwsewwwewneeswnwwwewwwenesw
            wenewseeeneneenenenenenwswswnenwnee
            neswnwnwesesenwswewneewsenwesweswswse
            nesweewswsewswnesewnewswwwwwsw
            nwneeeneseneneeneswenenwswnewsenwe
            swswswswnwswwswswesweeesenwswwswse
            senenwewnenenenenwnwneneswneenenenewne
            senwseneesweeesenenwseseseneewwe
            ewwwwwnesenesenwnwsewsesenenewswnw
            sewswswswseneswseseswseswneswswse
            eenwneneeeeeewswneseneeew
            swwwwseswswnweswwnwenenweenwseeene
            eeneeeeswnwneseenwesweeenweee
            enwwwwnwnwwwnwnwneseswswnwnwnwwenwnw
            wwwswswswswwswewswsw
            swwwwnesewswewwswneswseenw
            seeneeeeeweeeseee
            swneswwnwsenweswnweswswnwseeseseseswnw
            swswseswnwswswsweseswnwswswswneswsesew
            neneswswwwwwswwnwswswwswsesweswsesw
            sweneswnesenenwnenwesenewnwnewnwwene
            nwnwnenenwwnesweeswnwswseseneseewnw
            nenwnenenwneneneswneneenenwswnenw
            nwseswseswwwswnwneswswwswwwwswnese
            esenwenwnwwnewnwnwneswnwnwwnwnwnwnw
            wwwswsenwwswwwwwwnwnwwsewwe
            wesenweneeeseswseeneswswnenwwesw
            swswnwseseswsenwnenwnwseewweswswseene
            swswnewswswneswswswsenwweswwswswswsww
            eswwnenwnwneewenweswswnewweswese
            seneenwsewwnwnee
            swswswswsenwsweswswswenwswsenwswsesesw
            nwnweenwnwnenwnwneswswnwnwsenwnwnwnwnwne
            wnwwnwwwwwwsew
            nwswnwnwnenenwnwnwswnwseneswnwnwnwne
            newwneeeswseneeneneneneweeeenene
            eeenwnwneeeeeeesweenwswwseew
            esenewwwwnwswswswswwwnwswswswww
            eeweeeseseeesee
            wewwnenewswwneseswwnwwwseswswww
            wweenenewswswnwwewwswwwswswsww
            seseeswneesewnwsenwsesesesenwwswnwsee
            nwnwnenwnenwnwnwsesenwnwnwwnwnenenwnwse
            eswswseseswwswseseswswnweseswenwsesw
            eeseneneeesenenwswwweewneenene
            swsenwwswnwnwnwswnwenweneswneeneswnw
            nenwenenewseneweewswneenesweene
            swwwwwwwnwswew
            seesenwesesesewnwsenweseseswseswsee
            nenenwnwnenewnwnwnenwseswnwnwnwnenwseswse
            neneeeenwwweseseswewseesenwswnw
            enewesenenesenwwsesweneeneeneenenee
            seeeeeneewseewseseeeeesesewnw
            wwswswswswwwnwwewswsw
            wswnwnenweswnwnwnwnwnwnwsenwewse
            nwnwnwnwswnenenwenwenwnwneseswnwnwnenwne
            ewswswswwnwswswwswnwswswswswwwsesenwne
            wnwsenesenwsenwesewewseswnwnenwneswne
            nesweenenwneeneseeeneneseenewneenw
            nwswswswesenwsenwesweseswsewswesenwsw
            sweswneneeneswnwesenwwnwseeseswwnw
            enwnwnwnwnenwnwnwnenwwnwesewnwnwsenwnw
            eneseweeeneneneswwseneswweswswsw
            swswwwseneeseeewnwwseswnwswenwneswnw
            senewwswsesenewnwseseswswswneseneswsesw
            swnwnwnenwsenwsenwnwsenwnwwnwnwew
            seseseseswneesenweseeseswsesenwsewsese
            eewweeneneswswenenweneneeeesw
            ewneneeeseeeneneesweswenweswene
            wseeneseeswnwwesesesenwnwwsesee
            sesesesewseseneseseswnesesesenwsesenwse
            seseswseneneewseseseseseseesesee
            swswsesenwneeseswsesesesesesesew
            nenwseswswnesenewwnwenwseeeeneneenene
            neswneswswnewnwswnwseneeneneenwenwne
            swnwnwnwnwnwseenewnenenwnwnwnweewnwnw
            swnwnewnwwnwnwwnewswwsewwnwswnewew
            nwnenwswnenwnwnwnenesenwsenenwnenenesenwnw
            nenwewseswneweesweseeenweswswnw
            swsweswseeswwswswswneswwwnwnwswnwse
            swwwswwsewenewsewswswwnewnwswnw
            swenenwnweswnwswwswwwnwweswnewnw
            nwnenwnwnwnwwenenwnwsenenewenwnwswnesw
            neesewswnwswseswnwenenwwswswswswewse
            seseseseeeseseseswnw
            swswenwswnenwnwnenwnwnwsenenwnwnenenwnwnew
            wseseeeseseneseswesesesesese
            seswseseseseswneswnwwseseseswesw
            nwnwnwnwenweswsesenwswnwnwnwnwnwewswnwne
            swneneenenwnenenewneneeweeeeswnese
            wwnwnewwwwwswwww
            eseeeseeeeenwewseenwesenwwse
            seswseswneswseswswswwseswsw
            wneswseswswnwswneseswsweswneswwswswsesw
            wswwnwnwnwnwnesweswseswseswenwwswew
            neeeeswneeswnweeeeeeesweee
            neswswnwswesenwsenesenwsewseewswswne
            newseesesesenwsenwewsewsese
            sewseenwseseseswseseeswseseseneenwse
            weseneeeeeesewneseneeswewsew
            wswnwnwsewnwnwenwewwnwsesenwnenwnwnw
            senenenenenewnenwnwse
            seseseseseswsesenesesesesewsenwseneese
            swwneewwneswsewseseeneenwsenenese
            swnwnwneswseswsweswewneswnewnweseswsw
            swswswswseeswswnwseswswnw
            nenwseneenwneneenwneneneswseseeneswenw
            swneswswwswswseswswswswnweswewswswe
            swnenenwneswenenewnwnwnenenenese
            nwswswnewseswnwswnwwwesweeswesese
            nwenwnwnwnenwnwnesenwnwnwswnwnwsesenese
            sweewwnwswesewnenwswww
            eweneeswwswneeneeeseesenenwnee
            nwnwnwnwsewnwenwnwnweswwwnenwnwee
            seswswswwswnwwseneswswswswneswwswnene
            newnenenwnesenenesewneswnenwnwnwnenwne
            sewnenenenwneeswwenwneswnese
            swnwnwwnwnwnenwenenesenewneeswnenene
            swnenenesenewneneswsewwwwneesesee
            wewneneeneneswwwsenenesene
            wenwswswswnwwenwwwwenewnwnwwww
            wwewseswwwswswwwnewnewnwnwwwne
            swswwswswnwswnwswseswswswnwswswswseeswne
            wewswnweneeseseeweeeewwsene
            swsewwsenwseswewneswsesee
            seseswnwneneseesesesesesesenweewsesese
            seseseseswnesesesenwswsesew
            swnwseswewseswswswswswse
            wwesenwnwnweswswnwneewswnwneewse
            nwnwnwnwnwnesesenwnwsenewnwnwnwnwnwnwnw
            wswwwnenwswseswewwswswwnwwswswsw
            senenenewnenesenenenenenwenweese
            swneneeneswenewswnenwnweneesee
            neenenewneeewneneswseneseneneneene
            swnewswswsenwwswseswnweswswnwsweswsw
            ewwnwenwwwsewnwnwnwsesw
            seswseswswswseswsesenwsese
            neneswnweeeeeneeswwnwswseee
            swnenwnenwnwneswenenenwnenenweneneswnee
            nenenwnwneneneneswnenenwnwsenwnewesenwwe
            wwnwnwnenwwwwewseeswwwnwnwswnwnw
            neneeneeeeneneeeeewe
            nwneswweswswnesweesenwswswswswsesewse
            seewseneseneseseseswswewseeseenwsee
            nwswseswswseseswseswseswse
            swseewnwseswwwseeswswnesewneneese
            nwneeseeeneeeeeeee
            wwswenwwnwnwwwsenwwwwwnwsenew
            weneneneeneneswne
            nenwswneswswwswwwwwswenewwsesewsw
            sesesenenwneswwenesenewesweswseeenw
            sweewswwnwenwseseseenwsesw
            enwneenwewsenwnwwsewwwsww
            nwnweseneswneeneneneweswswwneseswnese
            nweseswneeseenwnenenesesenwenenenwwe
            nwwnwnwsenwnwnwenenwnwnwsenwswnwsenwwnw
            wewwwwseswnwsewwwnenwwwwsenesw
            seswseswswswswseseswnwswswesw
            sweswwnewneneneneneseneneneenwenene
            swwnwswswwwewswswenwwse
            senwenwnwwnwesesenwwnwnwnenwsenwnwnwne
            seseeeweseswwnenwsenesewnweseeese
            nwwewwnwnenwswnwsewswwnewenwnwnwnw
            eesweesenweewneeeeenwsweene
            newswesenwnewswneswswswseswswnwswnesw
            sesesewwsesewseseneeswsenesesenesese
            nwnwwswnwnenwwnwwnwnwneseswesenwswnwse
            wwnesewnwnesesewsewnwwneneswse
            eeweneeneweneeseeewneeeene
            neneswnenwnenenwnenenwnwnwene
            wwwseswswneenewseswseswwswnenesese
            nwnwnwnwseswwnwswnwnwsenwnwsenwsenenwnee
            newswswwwwseseneswwswswnewswwww
            seseseseneseseswswswseseesenesesewswnwse
            eeseswweseeenwsenesesesesesewsesee
            neenenenenenwnweesenwesenwenesenesee
            nwnwnwnenwswnwnwsenwnwnwnenewnwnw
            seswnewswswswswnwe
            eswnewneeneneneenenenwnenewnwewswse
            wnewnenenwnwseneneseswsewenwsesenwwwse
            eeseseweneseseewnesewnesesesenw
            seeneeeewseeeneewsesweeseee
            seseseswswsenwneeswnwswseseseswseswswnese
            sewwswswseneswnwwwwswwne
            nwnwnwnenwnwnwwnwnweswnwnwswenw
            seswnwseseswnwnwseseenenw
            newsewswnwwwneswsewneeeseswnwwenenw
            neneeswnenenewseesenewe
            seswneswsesewseeswse
            sesenwnewneneeeneneneenenenesewnenenenw
            wwneneswewswswsew
            sewwwnwnwnwwsenwnenwsesenww
            nwwnwnenenwwnwwswswswewseneesenewwnw
            eeswswneneneneeneeeeseeewneee
            wsewswwwnenwswnwswwsenenwenenw
            nwwnwwwwnwewnewwwsenwswwswenwne
            swsenesenwsesesewseswneeseseseseswsenw
            wswswswseeswswswswnwswneweseswswswswnw
            wnwnwwnwnwwnwnwwnwwswnwwenwwese
            swseesenwswnwsenwswsweeweenwneeenene
            neswnenewneneneneneneneneswnesenenesew
            wnwneenenewnenenesenwne
            senwnwseenesewseswwseswsweswsenenwsee
            nwnwnwwnwenwsweswwnwseenwwnwnwnwnw
            neseneneneswnwswsenewnewneenwsewnenenese
            nwseseswwswseesenesenese
            swsenwsewwneesewweswnenwneenwwnwse
            eswswwswnenewseseswnwseswswnewswswsesw
            wewneseeswwwnwneewnwswwswswwsesw
            swseeewseswwswswneswswnwswsw
            seewswwswwswsenwnwswwswnewswswswsww
            seswswswsesesenewswswsenwswswswneswswsw
            enwwwwswswwwswsewswnwnwseeswnwwsw
            seneseneswseswseseswwwsweseswnwesesese
            eswnesweswswswswnwswswswswwwsw
            eeeeweeseseneewe
            swnenwenwnwnenesewwswnwnwnwnwne
            seswneswswwwsewenewwswwswwwww
            seswseseswswswswswsenwsesenwneeewseswswse
            wwnwnwwwenwwnwnww
            seswseeseeseeneesesesewnese
            wnwnwwnesewwwswewsesewnwewwe
            swnwseswswswnweswneweswswswswswswnesw
            swseseseseseswswseswne
            nwswwwwnwswnwsesewenewwsesenwnenw
            swwnwsweeewnwnwwsweseswsw
            nwnwnwnweswnwsenwnwnwnwnwnwnwnww
            eswnenwswnwneeneee
            enweneeeeeeesenenee
            nwwnwweneeseenenenwnwnwwswswnenenw
            eeeneseesweeeewenwesweeee
            swswnewswwsesenwwswswwwwewneswswnesw
            seseseseseseseesesewesesewe
            neswwwwwneswwswwwwsewneneww
            wsewwwwwwnwnwnwwnwnww
            nenwneneneneneseneneenenenewneswnwesene
            swnwseseswswswseweswsweswswnwnesewseesw
            weswswneswseewwnwnwneseesese
            eewwnwnweswww
            swwwwwwwswsewwewswnewwneww
            senesesesenwnwnwnenewsenwnwnewnw
            nwnenwnwnenenwewseenwnwnenwnwwnewnw
            wwwweswwseneneseenwseswnwwnwwwnw
            nwnwwswnenwnwnwwwseewswnwnenweww
            neswnwnewneneeneneneneneneneneseswnesene
            eeenwewseeenwsewnwsewe
            nwnwwnwwnesenwnwnwnwnwnwsenwnwswnenwnw
            nwseswswswnewnenwnwneneenenwwneneeesw
            nwnwnwnwwswsenweenwnweenwnwnwswnwnww
            nwesweeeeenweeseweeeeewee
            swseseswseswswswswnwnwswswsweneswswsese
            swesesweeswswswnwwswswswsewse
            wswswweseswswswenwswnwswswnwwwwsw
            wsesesesenwswswnwseseseeseseesesesese
            wsenewwwwwwwwnewsew
            ewswwwwswwwwwnwweswww
            enwwnwnenwesewne
            wswswseswsesesenesesesese
            swseseseswseseseswswnewe
            swswnwnenenwswneneneneenenenenenwswnenw
            eneeseeseenewseeseewe
            nwneseswswswswswnwswswswswwneeseswswne
            swswsesesesenwseseesenew
            newnwsenwsenenwnwnenwnwnwnesenwwnwnw
            eneenenewwneneneneneneseneenesene
            wnwseweeenwswsewwneswwneenewewe
            nwnwnwwwnwwneenwsenenwseswnwswwnwnw
            nwnwswneneswnwnwnenwwnweswswwnwnenwnw
            neneenweseswseeewneweneenweseee
            eeneweseeeeenwsenweneeeeswswe
            ewsewswnwwwwnwneewseswneenewswwe
            eeweeesweeeneeeeswswseenwnwee
            nwnweswswsewwsenesweswwnwnwenwswe
            wwewwsesenwswnwwsenwnenwwnwsewwnw
            eewsewwnewwwwneswwwswswswww
            enwewswesenweenwneewseswseeee
            sesenewswwwweneneseeswnwnenwneee
            nwewnwsewnwnenwwnewwse
            eseeseseeesesesenwseneswneneswesew
            wswwseenewswenwwweswswnenww
            neseswseseeswswswwswswnwsenwsweseswswse
            eeswwenwnenwneeweseweswneswene
            nenwnenwnwnwneneswnenenenwneenenwswseswnw
            swneeeeseenweneseeweswneesenwenwsw
            nwnwnwsenwwnwsenwnwne
            newwnwsenwnewsewswnenwswwenenwnesese
            senwsenwnesenwnewnenwne
            """.lines

            let instructions = self.day.parse(input)
            _ = self.day.part2(instructions)
            DispatchQueue.main.async {
                self.label.text = "Finished"
                self.running = false
            }
        }
    }
}


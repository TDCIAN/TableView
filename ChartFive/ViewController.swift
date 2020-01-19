//
//  ViewController.swift
//  ChartFive
//
//  Created by APPLE on 2020/01/19.
//  Copyright © 2020 JeongminKim. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    let tableView: UITableView = {
       let tv = UITableView()
        tv.allowsSelection = false
        return tv
    }()
    
    let bandCellId = "bandCellId" // cellForRowAt indexPath 함수에 사용되는 아이덴티파이어

    // 'Top Bands' 섹션의 테이블뷰 셀에 들어갈 내용들 -> Info.swift에서 구조체로 형식이 정해짐(이미지, 타이틀)
    let bandsArray = [Info(image: "metalica", title: "Metallica"),
                      Info(image: "slipknot", title: "Slipknot"),
                      Info(image: "nirvana", title: "Nirvana"),
                      Info(image: "acdc", title: "AC/DC"),
                      Info(image: "system", title: "System Of A Down")]
    
    // 'Top Songs' 섹션의 테이블뷰 셀에 들어갈 내용들 -> Info.swift에서 구조체로 형식이 정해짐(이미지, 타이틀)
    let songsArray = [Info(image: "1", title: "The Unforgiven"),
                      Info(image: "2", title: "Snuff"),
                      Info(image: "3", title: "Smells Like Teen Spirit"),
                      Info(image: "4", title: "Back In Black"),
                      Info(image: "5", title: "Chop Suey")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .red // 기본 베이스뷰의 배경색
        
        setupNavigationBar()
        setupTableView()
    }
    
    // 네비게이션바 설정하는 공간
    func setupNavigationBar() {
        navigationItem.title = "ChartFive"
        navigationController?.navigationBar.barTintColor = UIColor.yellow
        navigationController?.navigationBar.isHidden = false
        
        // 네비게이션바 제목의 색상과 폰트 크기에 대한 설정
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.green, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 20)]
    }
    
    // 테이블뷰 설정하는 공간
    func setupTableView() {
        tableView.delegate = self // 얘는 기본적으로 있어야 함
        tableView.dataSource = self // 얘도 기본적으로 있어야 함
        
        tableView.backgroundColor = .cyan // 테이블뷰의 배경색 -> 셀의 배경색과는 별개임
        
        tableView.separatorStyle = .none // 세퍼레이터 스타일을 none으로 설정해주면 테이블뷰 셀 간 구분선이 사라진다
        
        // 테이블뷰에 셀을 등록을 해줘야 사용할 수 있음 -> dequeueReuseableCell로 연결하고, register로 등록한다
        tableView.register(BandCell.self, forCellReuseIdentifier: bandCellId)

        // 테이블뷰를 뷰에 올려 사용한다
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
    }
    
    // 헤더의 개수는 몇 개로 설정할 것이냐?
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    // 헤더의 높이는 몇으로 설정할 것이냐?
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    // 테이블뷰 헤더의 제목을 결정하는 함수
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        // 위(numberOfSections)에서 설정한 두 개의 섹션의 제목을 어떻게 설정할 것인가?
        if section == 1 { // 1번 섹션에는 "Top Songs"라는 제목을
            return "Top Songs"
        }
        return "Top Bands" // 그 외 섹션(0번 섹션)에는 "Top Bands"라는 제목을 주겠다
    }

    // 테이블뷰 헤더의 배경색과 제목의 색을 결정하는 함수
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.orange
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
    }
    
    // 섹션마다 몇 개의 셀을 보여줄 것이냐?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1{ // 만약 1번 섹션이라면('Top Songs'섹션)
            return songsArray.count // 송즈어레이의 숫자만큼을 보여주겠다
        }
        return bandsArray.count // 그게 아니라면('Top Bands' 섹션)의 밴즈어레이의 숫자만큼 보여주겠다
    }
    
    // 셀마다 무엇이 들어갈 것인가? -> 셀에 들어갈 내용을 구성하는 파일과 Identifier로 연결해줘야 한다
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: bandCellId, for: indexPath) as! BandCell // 밴드셀 클래스와 연결
        
        // 밴즈어레이에 있는 이미지와 텍스트를 보여줄 것이다 -> 형식은 Info.swift의 구조체에서 정해줬음(이미지, 타이틀)
        cell.pictureImageView.image = UIImage(named: bandsArray[indexPath.item].image!)
        cell.titleLabel.text = bandsArray[indexPath.item].title
        
        if indexPath.section == 1 { // 만약 1번 섹션('Top Songs' 섹션)이라면 밴즈어레이의 이미지와 텍스트를 보여줄 것이다
            cell.pictureImageView.image = UIImage(named: bandsArray[indexPath.item].image!)
            cell.titleLabel.text = songsArray[indexPath.item].title
        }
        
        return cell
    }
    
    // 셀의 높이를 몇으로 줄 것이냐?
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    


}

// 테이블뷰 셀에 대한 설정
class BandCell: UITableViewCell {
    
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemTeal // 테이블뷰 셀의 배경색
        return view
    }()
    
    // 셀에 들어가는 이미지뷰
    let pictureImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .red
        return iv
    }()
    
    // 셀에 들어가는 타이틀레이블
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = .yellow
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    
    func setup() {
        backgroundColor = UIColor.orange // 셀뷰 뒷면에 있는 기본 배경뷰의 색상임
        
        // 셀의 내용을 담을 셀뷰를 셀에 포함시킨다
        addSubview(cellView)
        cellView.addSubview(pictureImageView) // 이미지를 담을 이미지뷰를 셀뷰에 포함시킨다
        cellView.addSubview(titleLabel) // 타이틀 레이블을 셀뷰에 포함시킨다
        // 셀뷰에 대한 오토레이아웃 설정
        cellView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        // 셀뷰의 좌측에 들어갈 이미지뷰에 대한 오토레이아웃 설정
        pictureImageView.snp.makeConstraints {
            $0.leading.equalTo(cellView.snp.leading).offset(8)
            $0.centerY.equalTo(cellView.snp.centerY)
            $0.width.height.equalTo(40)
        }
        // 셀뷰에 이미지 다음으로 들어갈 타이틀 레이블에 대한 오토레이아웃 설정
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(cellView.snp.centerY)
            $0.leading.equalTo(pictureImageView.snp.trailing).offset(20)
            $0.trailing.equalTo(cellView.snp.trailing).offset(-20)
            $0.height.equalTo(40)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

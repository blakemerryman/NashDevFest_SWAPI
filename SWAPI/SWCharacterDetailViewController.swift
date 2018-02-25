//
//  SWCharacterDetailViewController.swift
//  SWAPI
//
//  Created by Blake Merryman on 2/14/18.
//  Copyright © 2018 Blake Merryman. All rights reserved.
//

import UIKit

class SWCharacterDetailViewController: UIViewController {

  let character: SWCharacter

  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.delegate = self
    tableView.dataSource = self
    tableView.isUserInteractionEnabled = false
    tableView.register(SWCharacterDetailCell.self,
                       forCellReuseIdentifier: String(describing: SWCharacterDetailCell.self))
    return tableView
  }()

  init(character: SWCharacter) {
    self.character = character
    super.init(nibName: nil, bundle: nil) // designated initializer
    self.title = character.name
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(tableView)

    tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

  }

}

extension SWCharacterDetailViewController: UITableViewDelegate {

  // intentionally unimplemented
  // we aren't handling any interactions

}

extension SWCharacterDetailViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return character.details.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SWCharacterDetailCell.self), for: indexPath)
    let detail = character.details[indexPath.row]
    cell.textLabel?.text = detail.key
    cell.detailTextLabel?.text = detail.value
    return cell
  }

}

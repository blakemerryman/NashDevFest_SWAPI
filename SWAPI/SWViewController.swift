//
//  SWViewController.swift
//  SWAPI
//
//  Created by Blake Merryman on 1/28/17.
//  Copyright © 2017 Blake Merryman. All rights reserved.
//

import UIKit

/*:
 # The View Controller

 - A simple table view to display a list of items.

 - Add button should generate a new item.

 */
class SWCharacterViewController: UIViewController, SWCharacterDataSourceDelegate {

  let dataSource = SWCharacterDataSource()

  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(UITableViewCell.self,
                       forCellReuseIdentifier: String(describing: UITableViewCell.self))
    return tableView
  }()

  lazy var addButton: UIBarButtonItem = {
    let button = UIBarButtonItem(barButtonSystemItem: .add,
                                 target: self,
                                 action: #selector(didTapButton(_:)))
    return button
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(tableView)

    tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

    navigationItem.rightBarButtonItem = addButton

    dataSource.delegate = self
  }

  func didTapButton(_ sender: UIBarButtonItem) {
    dataSource.loadNext()
  }

  func didUpdate(dataSource: SWCharacterDataSource) {
    tableView.reloadData()
  }
}

/*:
 # Conforming to UITableViewDelegate && UITableViewDataSource

 ## - UITableViewDelegate: provides general functionality handling (unimplemented)

 ## - UITableViewDataSource: provides the information & data we need to display things on screen

 */
extension SWCharacterViewController: UITableViewDelegate {

}

extension SWCharacterViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return dataSource.characters.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self), for: indexPath)

    let character = dataSource.characters[indexPath.item]
    cell.textLabel?.text = character.name
    return cell
  }
}

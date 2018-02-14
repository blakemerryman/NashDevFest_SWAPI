//
//  SWCharacterViewController.swift
//  SWAPI
//
//  Created by Blake Merryman on 1/28/17.
//  Copyright © 2017 Blake Merryman. All rights reserved.
//

import UIKit

/*:
 The View Controller Delegate

 - Delegates the responsibility for handling a selected character (e.g. displaying a view).

 */
protocol SWCharacterViewControllerDelegate: class {
  func didSelect(_ character: SWCharacter, from viewController: SWCharacterViewController)
}

/*:
 # The View Controller

 - A simple table view to display a list of items.

 - Add button should generate a new item.

 */
class SWCharacterViewController: UIViewController, SWCharacterDataSourceDelegate {

  weak var delegate: SWCharacterViewControllerDelegate?
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
                                 action: #selector(didTapAddButton(_:)))
    return button
  }()

  lazy var resetButton: UIBarButtonItem = {
    let button = UIBarButtonItem(barButtonSystemItem: .trash,
                                 target: self,
                                 action: #selector(didTapResetButton(_:)))
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
    navigationItem.leftBarButtonItem = resetButton

    dataSource.delegate = self
  }

  func didTapAddButton(_ sender: UIBarButtonItem) {
    dataSource.loadNext()
  }

  func didTapResetButton(_ sender: UIBarButtonItem) {
    dataSource.reset()
  }

  func didUpdate(dataSource: SWCharacterDataSource) {
    tableView.reloadData()
  }

}

/*:
 # Conforming to UITableViewDelegate && UITableViewDataSource

 ## - UITableViewDelegate: provides general functionality handling

 ## - UITableViewDataSource: provides the information & data we need to display things on screen

 */
extension SWCharacterViewController: UITableViewDelegate {

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let character = dataSource.characters[indexPath.row]
    delegate?.didSelect(character, from: self)
    tableView.deselectRow(at: indexPath, animated: true)
  }

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

import UIKit

/*:
 # The View Controller
 
 - A simple table view to display a list of items.
 
 - Add button should generate a new item.
 
 */

class SWCharacterViewController: UIViewController {

  var FAKE_NUMBER_OF_CELLS = 0

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
    let button = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapButton(_:)))
    return button
  }()

  func didTapButton(_ sender: UIBarButtonItem) {
    FAKE_NUMBER_OF_CELLS += 1
    tableView.reloadData()
  }












  override func viewDidLoad() {
    super.viewDidLoad()

    view.addSubview(tableView)
    tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

    navigationItem.rightBarButtonItem = addButton
  }

}







/*:
 # Conforming to UITableViewDelegate & UITableViewDataSource
 
 - UITableViewDelegate: provides general functionality handling (unimplemented)
 
 - UITableViewDataSource: provides the information & data we need to display things on screen
 
 */
extension SWCharacterViewController: UITableViewDelegate {
  // Intentionally left unimplemented!
}

extension SWCharacterViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return FAKE_NUMBER_OF_CELLS
  }

  func tableView(_ tableView: UITableView,
                 cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let cellID = String(describing: UITableViewCell.self)
    let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
    cell.textLabel?.text = Date().description
    return cell
  }
}












//: ----
//: # In Action...
//: > `presentViewController(controller:)` is a helper method to ensure playground runs async.

let vc = SWCharacterViewController()
presentViewController(controller: vc)





//
//  ViewController.swift
//  LL
//
//  Created by Jose Rivera on 10/12/2020.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainTableView: UITableView!
    var viewModel: ViewModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.viewModel = ViewModel(linkedList: LinkedList<String>())
        self.viewModel?.output = self
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        
    }
    
    
    @IBAction func didTapAddNodeButton(_ sender: Any) {
        let ac = UIAlertController(title: "Add node", message: "", preferredStyle: .alert)
        ac.addTextField { textField in
            textField.attributedPlaceholder = NSAttributedString.init(string: "Add value")
        }
        ac.addAction(UIAlertAction(title: "Submit", style: .default, handler: { [weak ac] _ in
            let textField = ac?.textFields![0]
            if let text = textField?.text {
                self.viewModel?.addValue(value: text)
            } else {
                ac?.message = "Please write something!"
            }
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        present(ac, animated: true)
    }
    
}

// MARK: - UITableView

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            self.viewModel?.remove(index: indexPath.row)
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel?.getList().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let node = self.viewModel?.getList()[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")

        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "Cell")
        }
        cell?.textLabel?.text = node?.value
        cell?.detailTextLabel?.text = "Previous: \(node?.previous?.value ?? "None") - Next: \(node?.next?.value ?? "None")"
        return cell!    
    }
}

// MARK: - Output

extension ViewController: ViewModelOutput {
    func showMessage(title: String, body: String) {
        let ac = UIAlertController(title: title, message: body, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func listUpdated() {
        self.mainTableView.reloadData()
    }
}


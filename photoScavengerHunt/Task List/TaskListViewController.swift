//
//  TaskListViewController.swift
//  photoScavengerHunt
//
//  Created by Snezhana Valchuk on 3/19/23.
//

import UIKit

class TaskListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tasks = [Task]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tableView.tableHeaderView = UIView()
        
        tableView.dataSource = self
        
        tasks = Task.mockedTasks
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // reloads and updates the data
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if let cell = sender as? UITableViewCell,
            
            let indexPath = tableView.indexPath(for: cell),
                
                let detailViewController = segue.destination as? TaskDetailViewController {
                    let task = tasks[indexPath.row]
                    
                    detailViewController.task=task
                }
            
        }
    }

extension TaskListViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskCell", for: indexPath) as! TaskCell
        
        let task = tasks[indexPath.row]
        

        cell.configure(with: task)

        return cell
    }
}


import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    
    @IBAction func saveBtnClicked(_ sender: Any) {
        // 예외처리 경고창
        if nameTextField.text == "" || ageTextField.text == "" {
            print("똑바로 입력할 것")
            let alert = UIAlertController(title: "실패", message: "이름과 나이 둘 다 제대로 입력하세요", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "확인", style: .default){(action) in }
            alert.addAction(okAction)
            present(alert, animated: false, completion: nil)
            return
        }
        let realm = try! Realm()
        let person = Person()
        person.name = String(describing: nameTextField.text!)
        person.age = Int(String(describing: ageTextField.text!))
        print(person)
        try! realm.write{
            realm.add(person)
        }
        displayLabel.text = "\(nameTextField.text!) \(ageTextField.text ?? "-1")가 추가되었습니다."
    }
    @IBAction func readBtnClicked(_ sender: Any) {
        
        let realm = try! Realm()
        let savedPerson = realm.objects(Person.self)
        var displayString:String = ""
        print("-> Person : ", savedPerson)
        if savedPerson.count == 0 {
            displayLabel.text = "저장된 사람이 없습니다."
            return
        }
        for i in 0..<savedPerson.count{
            displayString += "\(savedPerson[i].name) \(savedPerson[i].age ?? -1)\n"
        }
        print("-> displayString : ",displayString)
        displayLabel.numberOfLines = 0
        displayLabel.text = displayString
    }
    @IBAction func updateBtnClicked(_ sender: Any) {
        // 예외처리 경고창
        if nameTextField.text == "" || ageTextField.text == "" {
            print("똑바로 입력할 것")
            let alert = UIAlertController(title: "실패", message: "이름과 업데이트 할 나이를 둘 다 입력하세요", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "확인", style: .default){(action) in }
            alert.addAction(okAction)
            present(alert, animated: false, completion: nil)
            return
        }
        let realm = try! Realm()
        let savedPerson = realm.objects(Person.self)
        let filtered = savedPerson.filter("name == '\(nameTextField.text!)'")
        let filteredCnt = filtered.count
        if filteredCnt == 0 {
            displayLabel.text = "업데이트 할 대상이 없습니다."
        }
        else {
            for i in 0..<filteredCnt{
                try! realm.write {
                    filtered[i].age = Int(String(describing: ageTextField.text!))
                }
            }
            displayLabel.text = "\(nameTextField.text!)의 나이를 \(ageTextField.text!)로 업데이트 했습니다."
        }
    }
    @IBAction func deleteBtnClicked(_ sender: Any) {
        // 예외처리 경고창
        if nameTextField.text == "" {
            print("똑바로 입력할 것")
            let alert = UIAlertController(title: "실패", message: "이름을 입력하세요", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "확인", style: .default){(action) in }
            alert.addAction(okAction)
            present(alert, animated: false, completion: nil)
            return
        }
        let realm = try! Realm()
        let savedPerson = realm.objects(Person.self)
        let filtered = savedPerson.filter("name == '\(nameTextField.text!)'")
        print("-> filtered : \(filtered)")
        let filteredCnt = filtered.count
        print("count : ", filteredCnt)
        try! realm.write{
            realm.delete(filtered)
        }
        if filteredCnt==0 {
            displayLabel.text = "삭제할 대상이 없습니다."
        }
        else {
            displayLabel.text = "\(nameTextField.text!)가 정상적으로 삭제되었습니다."
        }
    }
    @IBAction func deleteAllBtnClicked(_ sender: Any) {
        let realm = try! Realm()
        let tasks = realm.objects(Person.self)
//        for i in 0..<tasks.count{
//            try! realm.write{
//                realm.delete(tasks[i])
//            }
//        }
        try! realm.write{
            realm.deleteAll()
        }
        displayLabel.text = "모두 삭제되었습니다."
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        operation()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
//        createPerson()
//        readPerson()
        print("viewDidLoad end")
        
    }
    
    
}

extension ViewController {
    
    func operation(){ // sample
//        let localRealm = try! Realm()
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        // ** CRUD ** //
        
        // CREATE
//        let task = LocalOnlyQsTask(name: "DO laundry")
//        try! localRealm.write {
//            localRealm.add(task)
//        }
        // Retreive Collection (READ)
//        let tasks = localRealm.objects(LocalOnlyQsTask.self)
//        print(tasks)
//
        // UPDATE
//        let taskToUpdate = tasks[0]
//        try! localRealm.write {
//            taskToUpdate.status = "InProgress"
//        }
        // DELETE
//        let taskToDelete = tasks[0]
//        try! localRealm.write{
//            localRealm.delete(taskToDelete)
//        }
    }
    func createPerson(){
//        let config = Realm.Configuration(schemaVersion: 2)
//        Realm.Configuration.defaultConfiguration = config
        let realm = try! Realm()
        let person1 = Person()
        person1.name = "철수"
        person1.age = 10
        let person2 = Person()
        person2.name = "영희"
        person2.age = 11

        try! realm.write{
            realm.add(person1)
            realm.add(person2)
        }
    }
    func readPerson(){
//        let config = Realm.Configuration(schemaVersion: 2)
//        Realm.Configuration.defaultConfiguration = config
//        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        let realm = try! Realm()
        let savedPerson = realm.objects(Person.self)
        let filter1 = savedPerson.filter("name == '철수'")
        print("-> Person : ", savedPerson)
        print("filter1 : ", filter1)
    }
}

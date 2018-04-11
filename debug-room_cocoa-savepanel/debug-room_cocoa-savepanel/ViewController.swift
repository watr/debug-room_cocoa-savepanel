
import Cocoa

class InputWindow: NSWindow {
    @IBOutlet var textView: NSTextView!
}

class ViewController: NSViewController {
    
    @IBOutlet var inputWindow: InputWindow!
    
    @IBAction func inputOKAction(_ sender: Any) {
        self.view.window?.endSheet(self.inputWindow,
                                   returnCode: .OK)
    }
    
    @IBAction func startAction(_ sender: Any) {
        if self.inputWindow == nil {
            let _ = Bundle.main.loadNibNamed(NSNib.Name(rawValue: "InputWindow"),
                                     owner: self, topLevelObjects: nil)
        }
        self.view.window?.beginSheet(self.inputWindow,
                                     completionHandler: { (response :NSApplication.ModalResponse) in
                                        let savePanel = NSSavePanel()
                                        savePanel.nameFieldStringValue = "text.txt"

                                        self.view.window?.beginSheet(savePanel, completionHandler: { (response :NSApplication.ModalResponse) in
                                            if response == .OK {
                                                if let url = savePanel.url {
                                                    self.saveInputText(to: url)
                                                }
                                            }
                                        })
        })
    }
    
    func saveInputText(to url: URL) {
        let text = self.inputWindow.textView.string
        if let data = text.data(using: .utf8) {
            let _ = try? data.write(to: url)
        }
    }
}


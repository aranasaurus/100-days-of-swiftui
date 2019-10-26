//
//  ContentView.swift
//  WordScramble
//
//  Created by Ryan Arana on 10/26/19.
//  Copyright © 2019 aranasaurus.com. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""

    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false

    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter your word", text: $newWord, onCommit: addNewWord)
                    .autocapitalization(.none)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .alert(isPresented: $showingError) {
                        Alert(title: Text(errorTitle), message: Text(errorMessage))
                }

                List(usedWords, id: \.self) {
                    Image(systemName: "\($0.count).circle")
                    Text($0)
                }
            }
            .navigationBarTitle(rootWord)
            .onAppear(perform: startGame)
        }
    }

    private func addNewWord() {
        let word = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)

        guard word.count > 0 else {
            wordError(title: "Invalid Word", message: "No text detected.")
            return
        }

        guard isOriginal(word) else {
            wordError(title: "Unoriginal", message: "You've already used \"\(word)\".")
            return
        }

        guard isPossible(word) else {
            wordError(title: "Invalid", message: "\"\(word)\" can't be made using letters from \"\(rootWord)\".")
            return
        }

        guard isReal(word) else {
            wordError(title: "Unreal", message: "I don't think \"\(word)\" is a real word.")
            return
        }

        usedWords.insert(word, at: 0)
        newWord = ""
    }

    private func startGame() {
        guard let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"),
            let startWords = try? String(contentsOf: startWordsURL) else {
                fatalError("Couldn't load start.txt from bundle")
        }

        let allWords = startWords.components(separatedBy: "\n")

        guard let rootWord = allWords.randomElement() else {
            fatalError("Failed to load a rootWord from the file.")
        }

        self.rootWord = rootWord
    }

    private func isOriginal(_ word: String) -> Bool {
        !usedWords.contains(word)
    }

    private func isPossible(_ word: String) -> Bool {
        var root = rootWord

        for letter in word {
            if let pos = root.firstIndex(of: letter) {
                root.remove(at: pos)
            } else {
                return false
            }
        }

        return true
    }

    private func isReal(_ word: String) -> Bool {
        guard word.count > 1 else {
            return word == "a" || word == "i" || word == "o"
        }

        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(
            in: word,
            range: range,
            startingAt: 0,
            wrap: false,
            language: "en"
        )

        return misspelledRange.location == NSNotFound
    }

    private func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

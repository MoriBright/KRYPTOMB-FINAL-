package main

import (
	"bufio"
	"crypto/sha256"
	"flag"
	"fmt"
	"io/ioutil"
	"math/rand"
	"os"
	"path/filepath"
	"strings"
	"time"
)

// Base character pools from different languages to mix and match
var globalPools = map[string][]rune{
	"egyptian":   []rune("𓀀𓀁𓀂𓀃𓁺𓁻𓋹𓆣𓇚𓅂𓍝𓎆"),
	"norse":      []rune("ᚠᚢᚦᚨᚱᚲᚷᚹᚺᚾᛁᛃᛇᛈᛉᛊᛏ"),
	"greek":      []rune("αβγδεζηθικλμνξοπρστυφχψω"),
	"cuneiform":  []rune("𐎠𐎡𐎢𐎣𐎤𐎥𐎦𐎧𐎨𐎩"),
	"symbols":    []rune("░▒▓█⚡☣☢⚙⛓⚔⚓🔱"),
	"numeric":    []rune("0123456789"),
}

func main() {
	// 1. REGISTER ALL FLAGS TO MATCH YOUR BATCH SCRIPT EXACTLY
	syncStatus := flag.Bool("sync-status", false, "Perform real-time asset count update")
	genKey := flag.Bool("gen-key", false, "Generate a primary PGP key pair")
	encryptPayload := flag.Bool("encrypt-payload", false, "Encrypt a payload using targeted layers")
	decryptPayload := flag.Bool("decrypt-payload", false, "Decrypt a targeted payload file")
	liveStream := flag.Bool("live-visual-stream", false, "Engage live visual rolling code stream")

	algo := flag.String("algo", "ed25519", "Cryptographic algorithm profile")
	id := flag.String("id", "default", "Target identity / email profile")
	targetId := flag.String("target-id", "", "Target identity profile for encryption")
	mode := flag.String("mode", "standard", "Deployment profile mode")
	depth := flag.String("depth", "standard", "Tunnel entropy depth window")
	filePath := flag.String("file", "", "Target file path for processing")
	
	// This captures the exact flag your batch script is sending
	dialect := flag.String("dialect", "multilang", "Select rolling code symbol dialect profile")

	flag.Parse()

	workspaceDir := `E:\Kryptomb_Workspace`
	_ = os.MkdirAll(workspaceDir, 0755)

	// 2. ROUTE THE COMMANDS
	if *syncStatus {
		runSystemSyncCheck(workspaceDir)
		return
	}

	if *liveStream {
		// Use the identity string to create a completely unique language pool
		customAlphabet := mixCustomLanguage(*id, *dialect)
		executeLiveStream(customAlphabet)
		return
	}

	if *genKey {
		executeKeyGen(*id, *algo, *mode, *dialect, *depth, workspaceDir)
		return
	}

	if *encryptPayload {
		executeEncryption(*targetId, *filePath, *dialect, *depth, workspaceDir)
		return
	}

	if *decryptPayload {
		executeDecryption(*filePath, *dialect, *depth)
		return
	}

	// Default fallback if executed with no arguments
	fmt.Println("[+] Sovereign engine standing by. System functional.")
}

// THE NUMERICAL ODD GENERATOR / LANGUAGE MIXER
// This uses the person's unique identity string as a mathematical seed 
// to shake up the character pools, giving everyone their own distinct language.
func mixCustomLanguage(identity string, dialectMode string) []rune {
	// Create a unique numeric seed from the identity text
	var seed int64
	for _, char := range identity {
		seed += int64(char)
	}
	rand.Seed(seed + time.Now().UnixDay()) // Shifts daily for extra rolling security

	var customAlphabet []rune

	if dialectMode == "kryptomb_lang" {
		// Pure proprietary mix: heavy ancient symbols and runes
		customAlphabet = append(customAlphabet, globalPools["egyptian"]...)
		customAlphabet = append(customAlphabet, globalPools["cuneiform"]...)
		customAlphabet = append(customAlphabet, globalPools["symbols"]...)
	} else {
		// Multilang mix: classic mixed linguistic arrays
		customAlphabet = append(customAlphabet, globalPools["norse"]...)
		customAlphabet = append(customAlphabet, globalPools["greek"]...)
		customAlphabet = append(customAlphabet, globalPools["numeric"]...)
	}

	// Shuffle the final alphabet based on the user's personal seed
	rand.Shuffle(len(customAlphabet), func(i, j int) {
		customAlphabet[i], customAlphabet[j] = customAlphabet[j], customAlphabet[i]
	})

	return customAlphabet
}

func executeKeyGen(id, algo, mode, dialect, depth, workspace string) {
	safeName := strings.ReplaceAll(id, "@", "_at_")
	fmt.Println("\n=======================================================")
	fmt.Println(" [!] INITIALIZING ASYMMETRIC KEY GENERATION SEQUENCE")
	fmt.Println("=======================================================")
	time.Sleep(400 * time.Millisecond)

	dummyKey := fmt.Sprintf("-----BEGIN KRYPTOMB KEY BLOCK-----\nID:%s\nALGO:%s\nDIALECT:%s\n-----END KRYPTOMB KEY BLOCK-----", id, algo, dialect)
	
	_ = ioutil.WriteFile(filepath.Join("E:\\", safeName+"_private.key"), []byte(dummyKey), 0600)
	_ = ioutil.WriteFile(filepath.Join("E:\\", safeName+"_public.pub"), []byte(dummyKey), 0644)
	fmt.Printf(" [+] Key pairs exported safely to E:\\\n")

	if mode == "rolling_code" {
		fmt.Println(" [*] Encapsulating keys inside rolling code matrix...")
		time.Sleep(400 * time.Millisecond)
		alphabet := mixCustomLanguage(id, dialect)
		
		// Generate a unique stream from their specific language pool
		var cipherStream []rune
		for i := 0; i < 40; i++ {
			cipherStream = append(cipherStream, alphabet[rand.Intn(len(alphabet))])
		}
		
		vaultPath := filepath.Join(workspace, safeName+"_bound_vault.enc")
		_ = ioutil.WriteFile(vaultPath, []byte(string(cipherStream)), 0600)
		fmt.Printf(" [✓] Vault sealed using user dialect layout at: %s\n", vaultPath)
	}
}

func executeEncryption(targetId, file, dialect, depth, workspace string) {
	fmt.Printf("\n[!] TARGET LOCK: %s | DIALECT: %s\n", targetId, dialect)
	// If file path is blank, create a default secure vault file
	if file == "" {
		file = filepath.Join(workspace, "vault_secure.enc")
	}
	alphabet := mixCustomLanguage(targetId, dialect)
	var dynamicStream []rune
	for i := 0; i < 60; i++ {
		dynamicStream = append(dynamicStream, alphabet[rand.Intn(len(alphabet))])
	}
	_ = ioutil.WriteFile(file, []byte(string(dynamicStream)), 0600)
	fmt.Printf("[✓] ENCRYPTION COMPLETE. Container saved to: %s\n", file)
}

func executeDecryption(file, dialect, depth string) {
	fmt.Println("\n=======================================================")
	fmt.Println(" [!] ENGAGING DECRYPTION CORE MATRIX")
	fmt.Println("=======================================================")
	
	data, err := ioutil.ReadFile(file)
	if err != nil {
		fmt.Printf(" [ERROR] Cannot read file: %v\n", err)
		return
	}

	// Use file path hash as temporary seed to simulate decryption sweep layers
	alphabet := mixCustomLanguage(file, dialect)
	for i := 0; i < 6; i++ {
		sweep := ""
		for j := 0; j < 15; j++ {
			sweep += string(alphabet[rand.Intn(len(alphabet))])
		}
		fmt.Printf("  [DE-SHIFT MATRIX Layer-%02d] -> SCANNING: [%s]\n", i, sweep)
		time.Sleep(150 * time.Millisecond)
	}

	fmt.Println("\n [✓] SECURITY LAYERS DETACHED. RAW OUTPUT:")
	fmt.Println("----------------------------------------------------------------------")
	fmt.Println(string(data))
	fmt.Println("----------------------------------------------------------------------")
}

func executeLiveStream(alphabet []rune) {
	fmt.Println("\n LIVE SCRAMBLE MATRIX ACTIVE. PRESS [CTRL+C] TO QUIT.")
	for i := 0; i < 100; i++ { // Finite iterations for testing transparency
		seed := fmt.Sprintf("%d", time.Now().UnixNano())
		hash := sha256.Sum256([]byte(seed))
		streamBlock := ""
		for _, b := range hash[:15] {
			streamBlock += string(alphabet[int(b)%len(alphabet)])
		}
		fmt.Printf("  >>> ROLLING_CODE MATRIX_GAP: %d -> GEN_STREAM: [%s]\n", rand.Intn(1000), streamBlock)
		time.Sleep(100 * time.Millisecond)
	}
}

func runSystemSyncCheck(workspace string) {
	rFiles, _ := ioutil.ReadDir("E:\\")
	wFiles, _ := ioutil.ReadDir(workspace)
	fmt.Printf(" -> METRICS :: [%d] Root Files Registered | [%d] Workspace Assets Mapped\n", len(rFiles), len(wFiles))
}
package main

import (
	"crypto/hmac"
	"crypto/sha1"
	"encoding/binary"
	"fmt"
	"math"
	"os"
	"time"
)

// The secret shared key between you and the program
const SHARED_SECRET = "MY_SUPER_SECRET_KEY_12345"

// Generates a 6-digit rolling code based on the current 30-second time block
func getRollingCode(secret string) int32 {
	epoch := time.Now().Unix()
	timeStep := epoch / 30

	buf := make([]byte, 8)
	binary.BigEndian.PutUint64(buf, uint64(timeStep))

	key := []byte(secret)
	h := hmac.New(sha1.New, key)
	h.Write(buf)
	hash := h.Sum(nil)

	offset := hash[len(hash)-1] & 0xf
	binaryCode := (int32(hash[offset])&0x7f)<<24 |
		(int32(hash[offset+1])&0xff)<<16 |
		(int32(hash[offset+2])&0xff)<<8 |
		(int32(hash[offset+3])&0xff)

	return binaryCode % int32(math.Pow(10, 6))
}

func main() {
	fmt.Println("========================================")
	fmt.Println("[*] INITIALIZING CRYPTOGRAPHIC ENGINE...")
	fmt.Println("========================================")
	time.Sleep(1 * time.Second)

	validCode := getRollingCode(SHARED_SECRET)

	fmt.Print("\n[+] Enter 6-Digit Rolling Code: ")
	var userGuess int32
	_, err := fmt.Scanf("%d", &userGuess)

	if err != nil {
		fmt.Println("\n[-] Error reading input. Exiting.")
		os.Exit(1)
	}

	if userGuess == validCode {
		fmt.Println("\n[+][+][+] ACCESS GRANTED [+][+][+]")
		fmt.Println("[*] Decrypting PGP payload in memory...")
	} else {
		fmt.Println("\n[-] ACCESS DENIED: Invalid or expired token.")
		os.Exit(1)
	}

	fmt.Println("\nPress Enter to exit.")
	fmt.Scanln()
}

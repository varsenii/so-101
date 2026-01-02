import cv2, time

cap = cv2.VideoCapture("/dev/video0")
prev = time.time()

count = 0

while True:
    ret, frame = cap.read()
    if not ret:
        break
    
    # Display the frame
    cv2.imshow('Video Stream', frame)
    
    # Count frames and check for exit key
    count += 1
    
    # Break if 'q' is pressed (also allows early exit)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

now = time.time()
print("FPS:", count / (now - prev))
cap.release()
cv2.destroyAllWindows()
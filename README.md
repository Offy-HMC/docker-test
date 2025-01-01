# test-docker

โปรเจคนี้เป็น demo สำหรับการใช้งาน docker ขั้นพื้นฐาน ที่ใช้สำหรับจำลอง environment ออกมาเป็น container เพื่อมาช่วยปิดเรื่องปัญหาที่มักเจออย่างเรื่อง environment ที่มักจะเจอได้บ่อยครั้งเมื่อต้องไป deploy ยังที่ต่างๆ (it's work on my machine)

## DOCKERFILE ---> IMAGE ---> CONTAINER

ใฟ้มองเหมือนการไรท์แผ่น cd จะง่ายหน่อย อย่าง

1. dockerfile เป็นการเขียน environment เตรียมไว้ว่าจะใช้อะไรทำอะไร
2. docker build ได้ image ออกมาตัวนี้จะมองเหมือนเป็น cd ที่พร้อมจะนำไปใช้งานแล้ว
3. docker run เป็นการนำ image ไปรันเป็น container ตัวนี้จะเหมือนแบบเสียบ cd รันโปรแกรมแล้ว ใช้ได้เลย
4. ปกติแล้วการ run ด้วย 3 ต้องมานั่งไล่ run image ทีละตัว จึงเกิดการทำ docker-compose ตัวนี้่ขึ้นมาเป็น tools ที่จะช่วยให้การรัน image นั้นง่ายขึ้น

## DOCKERFILE > DOCKER BUILD > IMAGE

เริ่มจากการเขียน dockerfile เอามา build สร้าง image

### build dockerfile command

```
docker build -t <image-name> <path เริ่มต้นที่จะใช้ run docker file>
docker build -t node-server -f ./Dockerfile .
docker build -t node-server .
```

## IMAGE > DOCKER RUN > CONTAINER

### pull image command

```
docker pull <url docker>
docker pull hello-world
```

### run image command

```
docker run -p <port outter>:<port inner> <image name>
docker run -p 8080:80 node-server
// -d for backgroud
docker run -d -p 8080:80 node-server
```

### list docker

```
docker ps
```

### show container logs

```
docker logs <container name>
```

### remove container

```
docker rm -r $(docker ps -a -q)
docker rm -r <container name>
```

## Docker-compose

เขียน service ที่ต้องการจะรันในไฟล์นี้ อย่างในตัวอย่างนี้จะเขียน node-server, db, phpmyadmin

### run container

```
docker-compose up -d --build
```

### remove container

```
docker-compose down
```

## Docker volume

Docker volume คือตัวที่ใช้สำหรับสร้าง persistent storage ที่ docker จะเก็บเอาไว้ (มองง่ายๆเป็นเหมือน disk จำลอง 1 ก้อน)

1. mount path ตรงๆ เข้าไปใน child ของ image

```
 volumes:
      - /data:/var/lib/mysql
```

2. map ด้วย docker volume

```
    volumes:
      - mysql_data_test:/var/lib/mysql # เปลี่ยน path เป็น volume ที่เราสร้างไปด้านล่างใน docker-compose
.
.
.

volumes:
  mysql_data_test: # กำหนดชื่อ volume ที่ต้องการจะสร้าง
    driver: local
```

### check docker volume list

```
docker volume ls
```

```
docker exec -it db sh
```

More information about this docker [docker-mike](https://docs.mikelopster.dev/c/basic/docker/basic)
[AskMe](https://www.askme.co.th/article/what-is-docker/)
[QuickServe](https://www.quickserv.co.th/knowledge-base/solutions/%e0%b8%a3%e0%b8%b9%e0%b9%89%e0%b8%88%e0%b8%b1%e0%b8%81%e0%b8%81%e0%b8%b1%e0%b8%9a-Docker-%e0%b9%81%e0%b8%9e%e0%b8%a5%e0%b8%95%e0%b8%9f%e0%b8%ad%e0%b8%a3%e0%b9%8c%e0%b8%a1%e0%b8%8b%e0%b8%ad%e0%b8%9f%e0%b8%95%e0%b9%8c%e0%b9%81%e0%b8%a7%e0%b8%a3%e0%b9%8c%e0%b8%aa%e0%b8%b3%e0%b8%ab%e0%b8%a3%e0%b8%b1%e0%b8%9a%e0%b8%99%e0%b8%b1%e0%b8%81%e0%b8%9e%e0%b8%b1%e0%b8%92%e0%b8%99%e0%b8%b2%e0%b9%81%e0%b8%a5%e0%b8%b0%e0%b8%9c%e0%b8%b9%e0%b9%89%e0%b8%94%e0%b8%b9%e0%b9%81%e0%b8%a5%e0%b8%a3%e0%b8%b0%e0%b8%9a%e0%b8%9a/?srsltid=AfmBOoqdWhHJKAHex-OYiZKngLqZPmbTQzsieFms-y43Xu8f-EkmiAme)
# docker-test

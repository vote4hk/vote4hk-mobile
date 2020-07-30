const Promise = require('bluebird');
const fs = Promise.promisifyAll(require('fs'));
const moment = require('moment');

const LOCALIZABLE_STORE_PATH = './lib/strings.json';
const LOCALIZABLE_DART_PATH = './lib/strings.dart';

let localizableMap = {};
let updated = false;

async function loadLocalizableMap(path) {
  // If any errors, abort the whole process to avoid overriding all contents
  const content = (await fs.readFileAsync(LOCALIZABLE_STORE_PATH)).toString();
  localizableMap = JSON.parse(content);  
}

function isJsonFileModifed(path) {
    const stat = fs.statSync(path);
    const lastSavedTime = moment(localizableMap.last_saved_time);
    const lastModifiedTime = moment(stat.mtime);
    return lastSavedTime.isBefore(lastModifiedTime);
}

async function getLocalizables(file) {
    const content = (await fs.readFileAsync(file)).toString();
    const regex = /i18n_(\w|_)*/g;
    let m;
    do {
        m = regex.exec(content);
        if (m) {
            const match = m[0];
            if (!localizableMap[match] && localizableMap[match] !== match) {
                localizableMap[match] = match;
                updated = true;
            }
        }
    } while (m);
}

async function analyseDirectory(dir) {
    const directories = await fs.readdirAsync(dir);
    for (const file of directories) {
        const fullPath = dir + '/' + file;
        if (fs.statSync(fullPath).isDirectory()) {
            await analyseDirectory(fullPath);
        } else {
            if (file.indexOf('.dart') > 0) {
                await getLocalizables(fullPath);
            }
        }
    }
}

async function outputJsonFile(path) {
    localizableMap.last_saved_time = moment().add(1, 'minute').format();
    fs.writeFileAsync(path, JSON.stringify(localizableMap, null, 2));
}

async function outputDartFile(path) {
    const content = `

class Strings {
    static final Map<String, String> _values = {
${Object.keys(localizableMap).map(key => `\t\t\t'${key}': '${localizableMap[key]}',\n`).join('')}
    };

    static String get(key) {
      return _values[key] ?? key;
    }
  }

  `

    await fs.writeFileAsync(path, content);
}

async function run() {
    console.log('going to extract the strings for localization..');
    // first load the json file containing previous extracted contents
    await loadLocalizableMap(LOCALIZABLE_STORE_PATH);

    // Then we extract all the 'i18n_' strings from all the .dart files
    const res = await analyseDirectory('./lib/src');
    updated = updated || isJsonFileModifed(LOCALIZABLE_STORE_PATH);
    if (updated) {
        // save the output json
        await outputJsonFile(LOCALIZABLE_STORE_PATH);
        await outputDartFile(LOCALIZABLE_DART_PATH);
    } else {
        console.log('Nothing to update ..');
    }

}

process.once('SIGUSR2', function () {
    gracefulShutdown(function () {
        process.kill(process.pid, 'SIGUSR2');
    });
});

run();

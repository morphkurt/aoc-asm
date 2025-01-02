mod y2015day1;
mod y2015day2;

use clap::Arg;
use clap::Command;
use std::collections::HashMap;
use std::fs;
use std::time::Instant;

fn main() {
    let mut functions: HashMap<&str, fn(input: &str) -> i64> = HashMap::new();
    functions.insert("y2015_day1_solve1", y2015day1::part1);
    functions.insert("y2015_day1_solve2", y2015day1::part2);
    functions.insert("y2015_day2_solve1", y2015day2::part1);
    functions.insert("y2015_day2_solve2", y2015day2::part2);

    let matches = Command::new("AOC in ASM")
        .version("0.1.0")
        .about("Solve AOC in ASM")
        .arg(
            Arg::new("day")
                .short('d')
                .default_value("2")
                .long("day")
                .help("aoc day"),
        )
        .arg(
            Arg::new("year")
                .short('y')
                .default_value("2015")
                .long("year")
                .help("aoc year"),
        )
        .arg(
            Arg::new("part")
                .short('p')
                .default_value("1")
                .long("part")
                .help("part"),
        )
        .arg(
            Arg::new("test")
                .short('t')
                .required(false)
                .num_args(0)
                .help("test"),
        )
        .arg(
            Arg::new("benchmark")
                .short('b')
                .required(false)
                .num_args(0)
                .help("test"),
        )
        .get_matches();

    let y_str: &String = matches.get_one("year").unwrap();
    let d_str: &String = matches.get_one("day").unwrap();
    let part_str: &String = matches.get_one("part").unwrap();
    let benchmark: &bool = matches.get_one("benchmark").unwrap();

    let fn_name = format!("y{}_day{}_solve{}", y_str, d_str, part_str);
    let input = fs::read_to_string(format!("inputs/{}/day{}/input", y_str, d_str))
        .expect(&format!("inputs/{}/day{}/input not found", y_str, d_str));
    let f = functions.get(fn_name.as_str()).unwrap();
    let now = Instant::now();
    let result = f(input.as_str());
    let elapsed = now.elapsed();


    let output = match benchmark {
        true => {
            format!(
                "answer for day {} part:{}: {}, running time: {:.2?}",
                d_str, part_str, result, elapsed
            )
        }
        false => {
            format!("answer for day {} part:{}: {}", d_str, part_str, result)
        }
    };

    println!("{}", output);
}

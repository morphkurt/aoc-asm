#[link(name = "aoc.a")]
extern "C" {
    fn y2015_day2_solve1(s: *const u8, len: usize) -> i64;
    fn y2015_day2_solve2(s: *const u8, len: usize) -> i64;
}

pub fn part1(input: &str) -> i64 {
    let input_ptr: *const u8 = input.as_ptr();
    // Get the length of the string
    let len = input.len();
    unsafe {
        let r = y2015_day2_solve1(input_ptr, len);
        return r;
    };
}

pub fn part1_in_rust(input: &str) -> i64 {
    let sum: u32 = input.lines().into_iter()
    .map(|l|{
        let mut v = l.split('x').into_iter().map(|v| v.parse().unwrap()).collect::<Vec<u32>>();
        v.sort();
        let mut s = (v[0]*v[1]+  v[0]*v[2] +  v[1]*v[2] )* 2;
        s+=v[0]*v[1];
        s
    }).sum();
    sum as i64
}

pub fn part2(input: &str) -> i64 {
    let input_ptr: *const u8 = input.as_ptr();
    // Get the length of the string
    let len = input.len();
    unsafe {
        let r = y2015_day2_solve2(input_ptr, len);
        return r;
    };
}

#[cfg(test)]
mod tests {
    use super::*;
    const EXAMPLE: &str = "2x3x4\n1x1x10\n";

    #[test]
    fn test_part1() {
        let result = part1(EXAMPLE);
        assert_eq!(result, 58);
    }

    #[test]
    fn test_part2() {
        let result = part2(EXAMPLE);
        assert_eq!(result, 48);
    }
}
